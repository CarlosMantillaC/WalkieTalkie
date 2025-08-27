//
//  AudioServiceTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class AudioServiceTests: XCTestCase {
    var audioService: AudioService!
    
    override func setUp() {
        super.setUp()
        audioService = AudioService()
    }

    func testPlayAudioDataShouldNotFailWithValidData() {
        let samples: [Int16] = [Int16.max, Int16.min, 0]
        let data = samples.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
        
        XCTAssertNoThrow(audioService.playAudioData(data))
    }
}
