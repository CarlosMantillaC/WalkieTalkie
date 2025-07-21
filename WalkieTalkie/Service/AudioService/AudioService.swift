//
//  AudioService.swift
//  WalkieTalkie
//

//

import AVFoundation

final class AudioService: AudioServiceProtocol {
    private let audioEngine = AVAudioEngine()
    private let playbackEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var inputNode: AVAudioInputNode?
    private var format: AVAudioFormat?
    private var socket: WebSocketServiceProtocol?
    
    init() {
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
            print("🔧 Audio session configured with sampleRate: \(session.sampleRate) Hz")
        } catch {
            print("❌ Failed to configure audio session: \(error.localizedDescription)")
        }
    }
    
    func startStreaming(to socket: WebSocketServiceProtocol) {
        self.socket = socket
        inputNode = audioEngine.inputNode
        
        guard let inputNode else {
            print("❌ No input node available")
            return
        }
        
        let inputFormat = inputNode.outputFormat(forBus: 0)
        self.format = inputFormat
        
        inputNode.installTap(onBus: 0, bufferSize: 2048, format: inputFormat) { [weak self] buffer, _ in
            guard let self else { return }
            
            let audioData = self.convertBufferToData(buffer: buffer)
            self.socket?.send(message: audioData.base64EncodedString())
        }
        
        do {
            try audioEngine.start()
            print("🎙️ Audio streaming started")
        } catch {
            print("❌ Failed to start audio engine: \(error)")
        }
    }
    
    func stopStreaming() {
        inputNode?.removeTap(onBus: 0)
        audioEngine.stop()
        print("🛑 Audio streaming stopped")
    }
    
    func playAudioData(_ data: Data) {
        guard let format = self.format,
              let buffer = dataToPCMBuffer(data: data, format: format) else {
            print("❌ Failed to prepare buffer for playback")
            return
        }
        
        if !playbackEngine.attachedNodes.contains(playerNode) {
            playbackEngine.attach(playerNode)
            playbackEngine.connect(playerNode, to: playbackEngine.mainMixerNode, format: format)
        }
        
        do {
            if !playbackEngine.isRunning {
                try playbackEngine.start()
            }
            
            playerNode.scheduleBuffer(buffer, at: nil, options: .interrupts)
            playerNode.play()
            print("🔊 Playing audio")
        } catch {
            print("❌ Playback error: \(error)")
        }
    }
    
    private func convertBufferToData(buffer: AVAudioPCMBuffer) -> Data {
        let audioBuffer = buffer.audioBufferList.pointee.mBuffers
        guard let mData = audioBuffer.mData else { return Data() }
        return Data(bytes: mData, count: Int(audioBuffer.mDataByteSize))
    }
    
    private func dataToPCMBuffer(data: Data, format: AVAudioFormat) -> AVAudioPCMBuffer? {
        let frameLength = UInt32(data.count) / format.streamDescription.pointee.mBytesPerFrame
        
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameLength) else {
            return nil
        }
        
        buffer.frameLength = frameLength
        let audioBuffer = buffer.audioBufferList.pointee.mBuffers
        guard let mData = audioBuffer.mData else { return nil }
        
        let bytePointer = mData.bindMemory(to: UInt8.self, capacity: data.count)
        data.copyBytes(to: bytePointer, count: data.count)
        
        return buffer
    }
}
