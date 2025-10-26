//
//  ChannelPrivateJoinInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateJoinInteractorTests: XCTestCase {

    var interactor: ChannelPrivateJoinInteractor!
    var mockRepository: MockChannelPrivateJoinRepository!
    var mockPresenter: MockChannelPrivateJoinPresenter!

    override func setUp() {
        super.setUp()
        mockRepository = MockChannelPrivateJoinRepository()
        mockPresenter = MockChannelPrivateJoinPresenter()
        interactor = ChannelPrivateJoinInteractor(repository: mockRepository)
        interactor.presenter = mockPresenter
    }

    func testJoinChannelSuccess() {
        let response = ChannelPrivateJoinResponse(id: 1, isPrivate: true, maxUsers: 10, message: "Success", name: "test")
        mockRepository.result = .success(response)

        interactor.joinChannel(name: "test", pin: "1234")

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.joinChannelCalled)
            XCTAssertTrue(self.mockPresenter.didJoinChannelCalled)
            XCTAssertFalse(self.mockPresenter.didFailToJoinChannelCalled)
            XCTAssertEqual(self.mockPresenter.response?.name, "test")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testJoinChannelFailure() {
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.result = .failure(error)

        interactor.joinChannel(name: "test", pin: "1234")

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.joinChannelCalled)
            XCTAssertFalse(self.mockPresenter.didJoinChannelCalled)
            XCTAssertTrue(self.mockPresenter.didFailToJoinChannelCalled)
            XCTAssertEqual(self.mockPresenter.error as NSError?, error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
