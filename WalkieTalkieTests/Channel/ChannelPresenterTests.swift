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
        XCTAssertEqual(mockInteractor.connectedChannelName, "General")
        XCTAssertNil(mockInteractor.connectedWithPin)
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }
    
    func testViewDidLoadWithPrivateChannel() {
        let privateChannel = Channel(name: "Private", isPrivate: true, maxUsers: 10)
        presenter = ChannelPresenter(channel: privateChannel)
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.promptForPINCalled)
        
        mockView.simulatePinEntry("1234")
        
        XCTAssertTrue(mockInteractor.connectCalled)
        XCTAssertEqual(mockInteractor.connectedChannelName, "Private")
        XCTAssertEqual(mockInteractor.connectedWithPin, "1234")
    }
    
    func testViewDidLoadWithPrivateChannelCancelPin() {
        let privateChannel = Channel(name: "Private", isPrivate: true, maxUsers: 10)
        presenter = ChannelPresenter(channel: privateChannel)
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.promptForPINCalled)
        
        mockView.simulatePinEntry(nil)
        
        XCTAssertFalse(mockInteractor.connectCalled)
        XCTAssertTrue(mockView.showDisconnectedStateCalled)
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

    func testDidTapDropdownCountUserNavigatesToListUsers() {
        presenter.didTapDropdownCountUser()

        XCTAssertTrue(mockRouter.navigateToListUsersCalled)
        XCTAssertEqual(mockRouter.listUsersChannelName, "General")
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
}
