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
        let publicChannels = [Channel(name: "Public1", isPrivate: false, maxUsers: 10)]
        let privateChannels = [Channel(name: "Private1", isPrivate: true, maxUsers: 5)]
        
        presenter.didLoadChannels(publicChannels: publicChannels, privateChannels: privateChannels)

        XCTAssertEqual(presenter.numberOfSections, 2)
        XCTAssertEqual(presenter.numberOfRows(in: 0), 1)
        XCTAssertEqual(presenter.numberOfRows(in: 1), 1)
        XCTAssertEqual(presenter.titleForHeader(in: 0), "Canales Privados")
        XCTAssertEqual(presenter.titleForHeader(in: 1), "Canales Públicos")
        XCTAssertTrue(mockView.reloadDataCalled)
    }

    func testDidFailLoadingChannelsShouldShowError() {
        let error = NSError(domain: "Test", code: 123, userInfo: [NSLocalizedDescriptionKey: "Algo falló"])
        presenter.didFailLoadingChannels(error: error)

        XCTAssertEqual(mockView.shownErrorMessage, "Algo falló")
    }
    
    func testDidSelectChannel() {
        let publicChannels = [Channel(name: "Public1", isPrivate: false, maxUsers: 10)]
        let privateChannels = [Channel(name: "Private1", isPrivate: true, maxUsers: 5)]
        var selectedChannel: Channel?
        presenter.onChannelSelected = { channel in
            selectedChannel = channel
        }
        presenter.didLoadChannels(publicChannels: publicChannels, privateChannels: privateChannels)
        
        let privateIndexPath = IndexPath(row: 0, section: 0)
        presenter.didSelectChannel(at: privateIndexPath)
        XCTAssertEqual(selectedChannel?.name, "Private1")
        
        let publicIndexPath = IndexPath(row: 0, section: 1)
        presenter.didSelectChannel(at: publicIndexPath)
        XCTAssertEqual(selectedChannel?.name, "Public1")
    }
}
