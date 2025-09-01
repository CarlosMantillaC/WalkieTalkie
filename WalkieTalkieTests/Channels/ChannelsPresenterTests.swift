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

    override func setUp() {
        super.setUp()
        
        presenter = ChannelsPresenter()
        mockView = MockChannelsView()
        mockInteractor = MockChannelsInteractor()

        presenter.view = mockView
        presenter.interactor = mockInteractor
    }

    func testViewDidLoadShouldCallLoadChannels() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockInteractor.loadChannelsCalled)
    }

    func testDidLoadChannelsShouldUpdateDataAndReloadView() {
        let channels = [Channel(name: "Canal 1"), Channel(name: "Canal 2")]
        presenter.didLoadChannels(channels)

        XCTAssertEqual(presenter.channelsCount, 2)
        XCTAssertTrue(mockView.reloadDataCalled)
    }

    func testDidFailLoadingChannelsShouldShowError() {
        let error = NSError(domain: "Test", code: 123, userInfo: [NSLocalizedDescriptionKey: "Algo falló"])
        presenter.didFailLoadingChannels(error: error)

        XCTAssertEqual(mockView.shownErrorMessage, "Algo falló")
    }
}
