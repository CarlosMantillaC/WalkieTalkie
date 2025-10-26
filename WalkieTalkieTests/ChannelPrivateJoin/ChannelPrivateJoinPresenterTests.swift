//
//  ChannelPrivateJoinPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateJoinPresenterTests: XCTestCase {

    var presenter: ChannelPrivateJoinPresenter!
    var mockView: MockChannelPrivateJoinView!
    var mockInteractor: MockChannelPrivateJoinInteractor!
    var mockRouter: MockChannelPrivateJoinRouter!

    override func setUp() {
        super.setUp()
        presenter = ChannelPrivateJoinPresenter()
        mockView = MockChannelPrivateJoinView()
        mockInteractor = MockChannelPrivateJoinInteractor()
        mockRouter = MockChannelPrivateJoinRouter()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testJoinChannel() {
        presenter.joinChannel(name: "test", pin: "1234")

        XCTAssertTrue(mockInteractor.joinChannelCalled)
        XCTAssertEqual(mockInteractor.channelName, "test")
        XCTAssertEqual(mockInteractor.pin, "1234")
    }

    func testDidJoinChannel() {
        let response = ChannelPrivateJoinResponse(id: 1, isPrivate: true, maxUsers: 10, message: "Success message", name: "test")

        presenter.didJoinChannel(response: response)

        XCTAssertTrue(mockView.showSuccessCalled)
        XCTAssertEqual(mockView.successMessage, "Success message")
    }

    func testDidFailToJoinChannel() {
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error message"])

        presenter.didFailToJoinChannel(with: error)

        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.errorMessage, "Error message")
    }
}
