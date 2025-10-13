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
    let sampleChannel = Channel(name: "General", isPrivate: false, maxUsers: 100)

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
    
    func testViewDidLoadWhenChannelIsNil() {
        presenter = ChannelPresenter(channel: nil)
        presenter.view = mockView
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.showDisconnectedStateCalled)
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
        XCTAssertFalse(mockRouter.presentModalCalled)
        XCTAssertFalse(mockRouter.navigateToSettingsCalled)
        XCTAssertFalse(mockRouter.navigateToChannelPrivateCreateCalled)
    }

    func testRefreshUsersCallsInteractorFetch() {
        presenter.refreshUsers()
        
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }

    func testDidTapDropdownPresentsModal() {
        presenter.didTapDropdown()
        
        XCTAssertTrue(mockRouter.presentModalCalled)
    }

    func testDidTapSettingsCallsRouter() {
        presenter.didTapSettings()

        XCTAssertTrue(mockRouter.navigateToSettingsCalled)
    }

    func testDidFetchUsersDisplaysOnView() {
        let emails = ["a@a.com", "b@b.com"]
        presenter.didFetchUsers(emails)
        
        XCTAssertEqual(mockView.usersShown, "2 conectados")
    }

    func testDidDisconnect() {
        presenter.didDisconnect()
        
        XCTAssertTrue(mockView.showDisconnectedStateCalled)
    }

    func testDidTapDropdownCountUserNavigatesToPrivateCreate() {
        presenter.didTapDropdownCountUser()

        XCTAssertTrue(mockRouter.navigateToChannelPrivateCreateCalled)
    }
}
