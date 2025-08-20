//
//  ChannelIntegrationTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsIntegrationTests: XCTestCase {
    var sut: ChannelPresenter!
    var mockView: MockChannelView!
    var mockRouter: MockChannelRouter!
    var mockSocket: MockWebSocketService!
    var mockAudio: MockAudioService!
    var mockRepo: MockChannelUsersRepository!
    var interactor: ChannelInteractor!
    
    override func setUp() {
        super.setUp()
        let channel = Channel(name: "General")
        
        mockView = MockChannelView()
        mockRouter = MockChannelRouter()
        mockSocket = MockWebSocketService()
        mockAudio = MockAudioService()
        mockRepo = MockChannelUsersRepository()
        
        interactor = ChannelInteractor(
            channel: channel,
            socket: mockSocket,
            audioService: mockAudio,
            usersRepository: mockRepo
        )
        
        sut = ChannelPresenter(channel: channel)
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = interactor
        interactor.presenter = sut
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockRouter = nil
        mockSocket = nil
        mockAudio = nil
        mockRepo = nil
        interactor = nil
        super.tearDown()
    }
    
    func testViewDidLoadShouldConnectAndFetchUsers() {
        mockRepo.mockResult = .success(["user1@mail.com", "user2@mail.com"])
        
        sut.viewDidLoad()
        
        XCTAssertEqual(mockView.channelName, "General")
        XCTAssertEqual(mockSocket.connectedChannel, "General")
        XCTAssertEqual(mockView.usersShown, ["user1@mail.com", "user2@mail.com"])
    }
    
    func testStartTalkingShouldSendMessageAndStartStreaming() {
        sut.startTalking()
        
        XCTAssertTrue(mockAudio.startStreamingCalled)
        XCTAssertEqual(mockSocket.sentMessages.last, "START")
    }
    
    func testStopTalkingShouldSendMessageAndStopStreaming() {
        sut.stopTalking()
        
        XCTAssertTrue(mockAudio.stopStreamingCalled)
        XCTAssertEqual(mockSocket.sentMessages.last, "STOP")
    }
    
    func test_didTapExit_shouldDisconnectAndSetViewDisconnected() {
        sut.didTapExit()
        
        XCTAssertTrue(mockSocket.disconnectCalled)
        XCTAssertEqual(mockView.channelName, "Desconectado")
    }
    
    func testLogoutShouldClearSessionAndNavigateToLogin() {
        sut.didTapLogout()
        
        XCTAssertTrue(mockRouter.navigateCalled)
        XCTAssertEqual(mockRouter.lastMessage, "Sesión cerrada exitosamente")
    }
    
    func test_interactorDidReceiveAudio_shouldPlayData() {
           let audioData = "dGVzdA==".data(using: .utf8)!
           
           interactor.didReceive(data: audioData)
           
           XCTAssertTrue(mockAudio.playedAudioData)
       }
}
