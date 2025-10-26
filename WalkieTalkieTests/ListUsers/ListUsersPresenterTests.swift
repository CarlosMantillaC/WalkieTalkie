//
//  ListUsersPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ListUsersPresenterTests: XCTestCase {

    var presenter: ListUsersPresenter!
    var mockView: MockListUsersView!
    var mockInteractor: MockListUsersInteractor!
    var mockRouter: MockListUsersRouter!

    override func setUp() {
        super.setUp()
        presenter = ListUsersPresenter()
        mockView = MockListUsersView()
        mockInteractor = MockListUsersInteractor()
        mockRouter = MockListUsersRouter()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testViewDidLoad() {
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchUsersCalled)
    }

    func testDidFetchUsers() {
        // Given
        let users = ["user1", "user2"]

        // When
        presenter.didFetchUsers(users)

        // Then
        XCTAssertEqual(presenter.numberOfRows(), 2)
        XCTAssertEqual(presenter.user(at: IndexPath(row: 0, section: 0)), "user1")
        XCTAssertTrue(mockView.reloadDataCalled)
    }

    func testDidFailToFetchUsers() {
        // Given
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error message"])

        // When
        presenter.didFailToFetchUsers(with: error)

        // Then
        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.errorMessage, "Error message")
    }
    
    func testConfigureCell() {
        // Given
        let users = ["user1"]
        presenter.didFetchUsers(users)
        let cell = ListUsersTableViewCell()
        let imageView = UIImageView()
        let label = UILabel()
        cell.customImageView = imageView
        cell.nameLabel = label
        
        // When
        presenter.configure(cell: cell, at: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(cell.nameLabel.text, "user1")
        XCTAssertNotNil(cell.customImageView.image)
    }
}
