//
//  AudioService.swift
//  WalkieTalkie
//

//

import AVFoundation
import os

final class AudioService: AudioServiceProtocol {
    private let audioEngine = AVAudioEngine()
    private let playbackEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var inputNode: AVAudioInputNode?
    
    private var playbackFormat: AVAudioFormat?
    private var socket: WebSocketServiceProtocol?
    private var converter: AVAudioConverter?
    
    private let logger = Logger(subsystem: "com..WalkieTalkie", category: "AudioService")
    
    init() {
        configureAudioSession()
        setupFormats()
    }
    
    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setPreferredSampleRate(48000)
            try session.setPreferredIOBufferDuration(0.02)
            try session.setActive(true)
            logger.info("Audio session configured: \(session.sampleRate) Hz")
        } catch {
            logger.error("Audio session config failed: \(error.localizedDescription)")
        }
    }
    
    private func setupFormats() {
        playbackFormat = AVAudioFormat(
            commonFormat: .pcmFormatFloat32,
            sampleRate: 16000,
            channels: 1,
            interleaved: true
        )
    }
    
    func startStreaming(to socket: WebSocketServiceProtocol) {
        self.socket = socket
        inputNode = audioEngine.inputNode
        
        guard let inputNode else {
            logger.error("No input node available")
            return
        }
        
        inputNode.removeTap(onBus: 0)
        
        let inputFormat = inputNode.inputFormat(forBus: 0)
        guard let targetFormat = AVAudioFormat(
            commonFormat: .pcmFormatInt16,
            sampleRate: 16000,
            channels: 1,
            interleaved: true
        ) else {
            logger.error("Failed to create target audio format")
            return
        }
        
        converter = AVAudioConverter(from: inputFormat, to: targetFormat)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { [weak self] buffer, _ in
            guard let self = self, let converter = self.converter else { return }
            
            guard let convertedBuffer = AVAudioPCMBuffer(pcmFormat: targetFormat, frameCapacity: AVAudioFrameCount(buffer.frameLength)) else {
                self.logger.error("Could not allocate PCM buffer")
                return
            }
            
            var error: NSError?
            let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
                outStatus.pointee = .haveData
                return buffer
            }
            
            let status = converter.convert(to: convertedBuffer, error: &error, withInputFrom: inputBlock)
            
            if status == .haveData {
                let audioData = convertedBuffer.int16ChannelData!.pointee
                let byteCount = Int(convertedBuffer.frameLength) * MemoryLayout<Int16>.stride
                let data = Data(bytes: audioData, count: byteCount)
                self.socket?.send(data: data)
            } else if let error {
                self.logger.error("Conversion error: \(error.localizedDescription)")
            }
        }
        
        do {
            try audioEngine.start()
            logger.info("Audio engine started")
        } catch {
            logger.error("Audio engine failed to start: \(error.localizedDescription)")
        }
    }
    
    func stopStreaming() {
        inputNode?.removeTap(onBus: 0)
        audioEngine.stop()
        logger.info("Streaming stopped")
    }
    
    func playAudioData(_ data: Data) {
        guard let buffer = int16DataToFloat32PCMBuffer(data: data) else {
            logger.error("Failed to convert data to buffer")
            return
        }
        
        guard let playbackFormat else {
            logger.error("Playback format not configured")
            return
        }
        
        if !playbackEngine.attachedNodes.contains(playerNode) {
            playbackEngine.attach(playerNode)
            playbackEngine.connect(playerNode, to: playbackEngine.mainMixerNode, format: playbackFormat)
        }
        
        do {
            if !playbackEngine.isRunning {
                try playbackEngine.start()
            }
            
            if !playerNode.isPlaying {
                playerNode.play()
            }
            
            playerNode.scheduleBuffer(buffer, at: nil, options: .interrupts, completionHandler: nil)
            
            logger.debug("Playing audio - frames: \(buffer.frameLength)")
        } catch {
            logger.error("Playback engine failed: \(error.localizedDescription)")
        }
    }
    
    private func int16DataToFloat32PCMBuffer(data: Data) -> AVAudioPCMBuffer? {
        guard let playbackFormat else {
            logger.error("Playback format not available")
            return nil
        }
        
        let sampleCount = data.count / MemoryLayout<Int16>.size
        
        guard let buffer = AVAudioPCMBuffer(pcmFormat: playbackFormat, frameCapacity: AVAudioFrameCount(sampleCount)) else {
            return nil
        }
        
        buffer.frameLength = AVAudioFrameCount(sampleCount)
        let floatChannel = buffer.floatChannelData![0]
        
        data.withUnsafeBytes { (rawBuffer: UnsafeRawBufferPointer) in
            let int16Pointer = rawBuffer.bindMemory(to: Int16.self)
            for i in 0..<sampleCount {
                floatChannel[i] = Float(int16Pointer[i]) / Float(Int16.max)
            }
        }
        
        return buffer
    }
}
