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
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
            print("🔧 Audio session configured")
        } catch {
            print("❌ Failed to configure audio session: \(error.localizedDescription)")
        }
    }

    func startStreaming(to socket: WebSocketServiceProtocol) {
        self.socket = socket
        inputNode = audioEngine.inputNode
        let inputFormat = inputNode?.outputFormat(forBus: 0)

        guard let validFormat = inputFormat,
              validFormat.sampleRate > 0,
              validFormat.channelCount > 0 else {
            print("❌ Invalid input format or no input available.")
            return
        }

        self.format = validFormat

        inputNode?.installTap(onBus: 0, bufferSize: 1024, format: validFormat) { [weak self] buffer, _ in
            guard let self = self else { return }
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
        guard let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1),
              let buffer = dataToPCMBuffer(data: data, format: format) else {
            print("❌ Failed to create format or buffer for playback")
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

            playerNode.scheduleBuffer(buffer, at: nil, options: .interrupts, completionHandler: nil)
            playerNode.play()
            print("🔊 Playing audio")
        } catch {
            print("❌ Failed to play audio: \(error)")
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

        data.copyBytes(to: mData.assumingMemoryBound(to: UInt8.self), count: data.count)
        return buffer
    }
}
