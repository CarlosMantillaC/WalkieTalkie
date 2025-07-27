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

    func testViewDidLoadShouldConnectAndFetchUsers() {
        presenter.viewDidLoad()

        XCTAssertTrue(mockInteractor.connectCalled)
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
        XCTAssertEqual(mockView.channelName, "General")
    }

    func testStartTalkingCallsInteractorStart() {
        presenter.startTalking()
        XCTAssertTrue(mockInteractor.startTalkingCalled)
    }

    func testStopTalkingCallsInteractorStop() {
        presenter.stopTalking()
        XCTAssertTrue(mockInteractor.stopTalkingCalled)
    }

    func testDidTapExitDisconnectsAndNavigates() {
        presenter.didTapExit()
        XCTAssertTrue(mockInteractor.disconnectCalled)
        XCTAssertTrue(mockRouter.navigateCalled)
    }

    func testRefreshUsersCallsInteractorFetch() {
        presenter.refreshUsers()
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }

    func testDidFetchUsersDisplaysOnView() {
        let emails = ["a@a.com", "b@b.com"]
        presenter.didFetchUsers(emails)
        XCTAssertEqual(mockView.usersShown, emails)
    }
}
