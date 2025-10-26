//
//  ChannelPrivateCreateInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateCreateInteractorTests: XCTestCase {

    var interactor: ChannelPrivateCreateInteractor!
    var mockRepository: MockChannelPrivateCreateRepository!
    var mockPresenter: MockChannelPrivateCreatePresenter!

    override func setUp() {
        super.setUp()
        mockRepository = MockChannelPrivateCreateRepository()
        mockPresenter = MockChannelPrivateCreatePresenter()
        interactor = ChannelPrivateCreateInteractor(repository: mockRepository)
        interactor.presenter = mockPresenter
    }

    func testCreateChannelSuccess() {
        let response = ChannelPrivateCreateResponse(id: 1, isPrivate: true, maxUsers: 10, message: "Success", name: "test")
        mockRepository.result = .success(response)

        interactor.createChannel(name: "test", pin: "1234")

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.createChannelCalled)
            XCTAssertTrue(self.mockPresenter.didCreateChannelCalled)
            XCTAssertFalse(self.mockPresenter.didFailToCreateChannelCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testCreateChannelFailure() {
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.result = .failure(error)

        interactor.createChannel(name: "test", pin: "1234")

        let expectation = self.expectation(description: "Presenter is called on the main thread")
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockRepository.createChannelCalled)
            XCTAssertFalse(self.mockPresenter.didCreateChannelCalled)
            XCTAssertTrue(self.mockPresenter.didFailToCreateChannelCalled)
            XCTAssertEqual(self.mockPresenter.error as NSError?, error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
