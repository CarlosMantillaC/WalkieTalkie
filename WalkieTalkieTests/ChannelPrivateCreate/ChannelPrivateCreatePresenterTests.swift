//
//  ChannelPrivateCreatePresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateCreatePresenterTests: XCTestCase {

    var presenter: ChannelPrivateCreatePresenter!
    var mockView: MockChannelPrivateCreateView!
    var mockInteractor: MockChannelPrivateCreateInteractor!
    var mockRouter: MockChannelPrivateCreateRouter!

    override func setUp() {
        super.setUp()
        presenter = ChannelPrivateCreatePresenter()
        mockView = MockChannelPrivateCreateView()
        mockInteractor = MockChannelPrivateCreateInteractor()
        mockRouter = MockChannelPrivateCreateRouter()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testCreateChannel() {
        presenter.createChannel(name: "test", pin: "1234")

        XCTAssertTrue(mockInteractor.createChannelCalled)
        XCTAssertEqual(mockInteractor.channelName, "test")
        XCTAssertEqual(mockInteractor.pin, "1234")
    }

    func testDidCreateChannel() {
        presenter.didCreateChannel()

        XCTAssertTrue(mockView.showSuccessCalled)
        XCTAssertEqual(mockView.successMessage, "Se ha creado el canal correctamente")
    }

    func testDidFailToCreateChannel() {
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error message"])

        presenter.didFailToCreateChannel(with: error)

        XCTAssertTrue(mockView.showErrorCalled)
        XCTAssertEqual(mockView.errorMessage, "Error message")
    }
}
