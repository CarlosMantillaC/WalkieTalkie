//
//  ListUsersInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ListUsersInteractorTests: XCTestCase {

    var interactor: ListUsersInteractor!
    var mockRepository: MockListUsersRepository!
    var mockPresenter: MockListUsersPresenter!

    override func setUp() {
        super.setUp()
        mockRepository = MockListUsersRepository()
        mockPresenter = MockListUsersPresenter()
        interactor = ListUsersInteractor(channelName: "test", repository: mockRepository)
        interactor.presenter = mockPresenter
    }

    func testFetchUsersSuccess() {
        let users = ["user1", "user2"]
        mockRepository.result = .success(users)

        interactor.fetchUsers()

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.fetchUsersCalled)
            XCTAssertTrue(self.mockPresenter.didFetchUsersCalled)
            XCTAssertFalse(self.mockPresenter.didFailToFetchUsersCalled)
            XCTAssertEqual(self.mockPresenter.users, users)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testFetchUsersFailure() {
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.result = .failure(error)

        interactor.fetchUsers()

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.fetchUsersCalled)
            XCTAssertFalse(self.mockPresenter.didFetchUsersCalled)
            XCTAssertTrue(self.mockPresenter.didFailToFetchUsersCalled)
            XCTAssertEqual(self.mockPresenter.error as NSError?, error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
