//
//  SettingsPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class SettingsPresenterTests: XCTestCase {
    var presenter: SettingsPresenter!
    var mockView: MockSettingsView!
    var mockInteractor: MockSettingsInteractor!
    var mockRouter: MockSettingsRouter!

    override func setUp() {
        super.setUp()
        presenter = SettingsPresenter()
        mockView = MockSettingsView()
        mockInteractor = MockSettingsInteractor()
        mockRouter = MockSettingsRouter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testDidLogoutSuccessfullyHidesLoadingAndNavigatesToLogin() {
        let expectation = XCTestExpectation(description: "Wait for main queue dispatch for UI updates")

        presenter.didLogoutSuccessfully()

        DispatchQueue.main.async {
            XCTAssertTrue(self.mockView.hideLoadingCalled, "View should be told to hide the loading indicator")
            XCTAssertTrue(self.mockRouter.navigateToLoginCalled, "Router should be told to navigate to the login screen")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewDidLoadDoesNotCrash() {
        presenter.viewDidLoad()
        // No assertions needed, the test passes if no crash occurs.
    }
}
