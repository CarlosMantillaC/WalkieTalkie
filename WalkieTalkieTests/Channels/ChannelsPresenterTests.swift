//
//  ChannelsPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsPresenterTests: XCTestCase {
    var presenter: ChannelsPresenter!
    var mockView: MockChannelsView!
    var mockInteractor: MockChannelsInteractor!
    var mockRouter: MockChannelsRouter!

    override func setUp() {
        super.setUp()
        presenter = ChannelsPresenter()
        mockView = MockChannelsView()
        mockInteractor = MockChannelsInteractor()
        mockRouter = MockChannelsRouter()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testViewDidLoad_ShouldCallLoadChannels() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.loadChannelsCalled)
    }

    func testDidLoadChannels_ShouldUpdateDataAndReloadView() {
        let channels = [Channel(name: "Canal 1"), Channel(name: "Canal 2")]
        presenter.didLoadChannels(channels)

        XCTAssertEqual(presenter.channelsCount, 2)
        XCTAssertTrue(mockView.reloadDataCalled)
    }

    func testDidFailLoadingChannels_ShouldShowError() {
        let error = NSError(domain: "Test", code: 123, userInfo: [NSLocalizedDescriptionKey: "Algo falló"])
        presenter.didFailLoadingChannels(error: error)

        XCTAssertEqual(mockView.shownErrorMessage, "Algo falló")
    }

    func testDidSelectChannel_ShouldNavigate() {
        let channel = Channel(name: "Test")
        presenter.didLoadChannels([channel])

        presenter.didSelectChannel(at: 0)

        XCTAssertEqual(mockRouter.navigatedChannel?.name, "Test")
    }

    func testDidTapLogout_ShouldCallInteractor() {
        presenter.didTapLogout()
        XCTAssertTrue(mockInteractor.logoutCalled)
    }

    func testLogoutSucceeded_ShouldNavigateToLogin() {
        presenter.logoutSucceeded(message: "Adiós")
        XCTAssertEqual(mockRouter.logoutMessage, "Adiós")
    }
}
