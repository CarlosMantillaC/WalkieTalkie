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

    func testDidTapLogoutDelegatesToView() {
        presenter.didTapLogout()
        
        XCTAssertTrue(mockView.showLogoutConfirmationCalled)
    }

    func testConfirmLogoutTappedDelegatesToViewAndInteractor() {
        presenter.confirmLogoutTapped()
        
        XCTAssertTrue(mockView.showLoadingCalled)
        XCTAssertTrue(mockInteractor.performLogoutCalled)
    }
    
    func testDidLogoutSuccessfullyDelegatesToViewAndRouter() {
        let expectation = XCTestExpectation(description: "Main queue async executed")
        
        presenter.didLogoutSuccessfully()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(self.mockView.hideLoadingCalled)
        XCTAssertTrue(self.mockRouter.navigateToLoginCalled)
    }
}
