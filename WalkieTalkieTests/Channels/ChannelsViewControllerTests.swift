//
//  ChannelsFunctionalTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsViewControllerTests: XCTestCase {
    var viewController: ChannelsViewController!
    var mockPresenter: MockChannelsPresenter!

    override func setUp() {
        super.setUp()
        viewController = ChannelsViewController()
        mockPresenter = MockChannelsPresenter()
        viewController.presenter = mockPresenter
        _ = viewController.view
    }

    func testViewDidLoadShouldNotifyPresenter() {
        viewController.viewDidLoad()
        XCTAssertTrue(mockPresenter.viewDidLoadCalled)
    }

    func testReloadDataShouldReloadTableView() {
        let tableView = viewController.tableView!
        let dataSource = MockChannelsPresenter()
        dataSource.mockChannels = [Channel(name: "Test")]

        viewController.presenter = dataSource
        viewController.reloadData()

        let rows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(rows, 1)
    }

    func testDidSelectRowShouldCallPresenter() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.presenter = mockPresenter

        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(mockPresenter.selectedIndex, 0)
    }

    func testCellForRowShouldConfigureCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        mockPresenter.mockChannels = [Channel(name: "Mock")]

        viewController.presenter = mockPresenter
        viewController.reloadData()

        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as? ChannelsTableViewCell
        XCTAssertEqual(cell?.customLabel.text, "Mock")
    }
}
