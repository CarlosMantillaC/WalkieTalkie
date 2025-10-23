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
    var mockUsersRepository: MockChannelUsersRepository!
    var mockPresenter: MockChannelPresenter!

    override func setUp() {
        super.setUp()
        
        mockSocket = MockWebSocketService()
        mockAudioService = MockAudioService()
        mockUsersRepository = MockChannelUsersRepository()
        mockPresenter = MockChannelPresenter()

        interactor = ChannelInteractor(
            channel: Channel(name: "TestChannel", isPrivate: false, maxUsers: 100),
            socket: mockSocket,
            audioService: mockAudioService,
            usersRepository: mockUsersRepository
        )
        interactor.presenter = mockPresenter
    }

    func testConnectToChannelShouldStartAndStopStreaming() {
        interactor.connectToChannel(named: "TestChannel", pin: nil)

        XCTAssertEqual(mockSocket.connectedChannel, "TestChannel")
        XCTAssertNil(mockSocket.connectedWithPin)
        XCTAssertTrue(mockAudioService.startStreamingCalled)
        XCTAssertTrue(mockAudioService.stopStreamingCalled)
    }

    func testConnectToPrivateChannelShouldUsePIN() {
        interactor.connectToChannel(named: "PrivateChannel", pin: "1234")

        XCTAssertEqual(mockSocket.connectedChannel, "PrivateChannel")
        XCTAssertEqual(mockSocket.connectedWithPin, "1234")
    }

    func testStartTalkingShouldSendStartAndStartStreaming() {
        interactor.startTalking()

        XCTAssertTrue(mockAudioService.startStreamingCalled)
    }

    func testStopTalkingShouldSendStopAndStopStreaming() {
        interactor.stopTalking()

        XCTAssertTrue(mockAudioService.stopStreamingCalled)
    }

    func testDisconnectFromChannelShouldCallDisconnect() {
        interactor.disconnectFromChannel()

        XCTAssertTrue(mockSocket.disconnectCalled)
    }

    func testFetchUsersSuccessShouldNotifyPresenter() {
        let expectedUsers = ["a@a.com", "b@b.com"]
        mockUsersRepository.resultToReturn = .success(expectedUsers)

        interactor.fetchUsersInChannel(named: "TestChannel")

        XCTAssertEqual(mockPresenter.fetchedEmails, expectedUsers)
    }

    func testFetchUsersFailureShouldNotNotifyPresenter() {
        mockUsersRepository.resultToReturn = .failure(NSError(domain: "TestError", code: 1))

        interactor.fetchUsersInChannel(named: "TestChannel")

        XCTAssertNil(mockPresenter.fetchedEmails)
    }


    func testDidDisconnectSuccessShouldNotifyPresenter() {
        interactor.disconnectFromChannel()
        
        XCTAssertTrue(mockPresenter.didDisconnectCalled)
    }
}
