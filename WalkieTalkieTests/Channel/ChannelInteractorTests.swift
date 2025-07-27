//
//  ChannelInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelInteractorTests: XCTestCase {
    var interactor: ChannelInteractor!
    var mockSocket: MockWebSocketService!
    var mockAudioService: MockAudioService!
    var mockPresenter: MockChannelPresenter!

    override func setUp() {
        super.setUp()
        mockSocket = MockWebSocketService()
        mockAudioService = MockAudioService()
        mockPresenter = MockChannelPresenter()
        
        interactor = ChannelInteractor(
            channel: Channel(name: "TestChannel"),
            socket: mockSocket,
            audioService: mockAudioService,
        )
        
        interactor.presenter = mockPresenter
    }
    
    func testConnectToChannelShouldStartAndStopStreaming() {
        interactor.connectToChannel(named: "TestChannel")
        
        XCTAssertEqual(mockSocket.connectedChannel, "TestChannel")
        XCTAssertTrue(mockAudioService.startStreamingCalled)
        XCTAssertTrue(mockAudioService.stopStreamingCalled)
    }

    func testStartTalkingShouldSendStartAndStartStreaming() {
        interactor.startTalking()
        
        XCTAssertEqual(mockSocket.sentMessages.first, "START")
        XCTAssertTrue(mockAudioService.startStreamingCalled)
    }

    func testStopTalkingShouldSendStopAndStopStreaming() {
        interactor.stopTalking()
        
        XCTAssertEqual(mockSocket.sentMessages.first, "STOP")
        XCTAssertTrue(mockAudioService.stopStreamingCalled)
    }

    func testDisconnectFromChannelShouldCallDisconnect() {
        interactor.disconnectFromChannel()
        XCTAssertTrue(mockSocket.disconnectCalled)
    }
}
