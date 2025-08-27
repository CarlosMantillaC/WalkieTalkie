//
//  ChannelPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelPresenterTests: XCTestCase {
    var presenter: ChannelPresenter!
    var mockView: MockChannelView!
    var mockInteractor: MockChannelInteractor!
    var mockRouter: MockChannelRouter!
    let sampleChannel = Channel(name: "General")

    override func setUp() {
        super.setUp()
        mockView = MockChannelView()
        mockInteractor = MockChannelInteractor()
        mockRouter = MockChannelRouter()
        presenter = ChannelPresenter(channel: sampleChannel)
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testViewDidLoadWithChannel() {
        presenter.viewDidLoad()

        XCTAssertEqual(mockView.channelName, "General")
        XCTAssertTrue(mockInteractor.connectCalled)
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }

    func testViewDidLoadWithoutChannel() {
        presenter = ChannelPresenter(channel: nil)
        presenter.view = mockView
        presenter.interactor = mockInteractor

        presenter.viewDidLoad()

        XCTAssertEqual(mockView.channelName, "Desconectado")
        XCTAssertFalse(mockInteractor.connectCalled)
        XCTAssertFalse(mockInteractor.fetchUsersCalled)
    }

    func testStartTalkingCallsInteractorStart() {
        presenter.startTalking()
        
        XCTAssertTrue(mockInteractor.startTalkingCalled)
    }

    func testStopTalkingCallsInteractorStop() {
        presenter.stopTalking()
        
        XCTAssertTrue(mockInteractor.stopTalkingCalled)
    }

    func testDidTapExitDisconnectsAndSetsDisconnected() {
        presenter.didTapExit()
        
        XCTAssertTrue(mockInteractor.disconnectCalled)
        XCTAssertEqual(mockView.channelName, "Desconectado")
        XCTAssertFalse(mockRouter.navigateCalled)
    }

    func testRefreshUsersCallsInteractorFetch() {
        presenter.refreshUsers()
        
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }

    func testRefreshUsersWithoutChannelDoesNothing() {
        presenter = ChannelPresenter(channel: nil)
        presenter.interactor = mockInteractor
        
        presenter.refreshUsers()
        
        XCTAssertFalse(mockInteractor.fetchUsersCalled)
    }

    func testDidTapLogoutCallsInteractorLogout() {
        presenter.didTapLogout()
        
        XCTAssertTrue(mockInteractor.logoutCalled)
    }

    func testDidTapDropdownPresentsModal() {
        presenter.didTapDropdown()
        
        XCTAssertTrue(mockRouter.presentModalCalled)
    }

    func testDidFetchUsersDisplaysOnView() {
        let emails = ["a@a.com", "b@b.com"]
        presenter.didFetchUsers(emails)
        
        XCTAssertEqual(mockView.usersShown, emails)
    }

    func testLogoutSucceededNavigatesToLogin() {
        presenter.logoutSucceeded(message: "Sesión cerrada")
        
        XCTAssertTrue(mockRouter.navigateCalled)
        XCTAssertEqual(mockRouter.lastMessage, "Sesión cerrada")
    }
}
