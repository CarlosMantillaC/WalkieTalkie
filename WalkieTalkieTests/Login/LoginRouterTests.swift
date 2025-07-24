//
//  LoginRouterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginRouterTests: XCTestCase {
    
    func testCreateModuleReturnsConfiguredLoginViewController() {
        let viewController = LoginRouter.createModule()
        
        guard let loginVC = viewController as? LoginViewController else {
            XCTFail("Expected LoginViewController")
            return
        }
        
        XCTAssertNotNil(loginVC.presenter)
        
        guard let presenter = loginVC.presenter as? LoginPresenter else {
            XCTFail("Expected presenter to be LoginPresenter")
            return
        }
        
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.router)
        
        guard let interactor = presenter.interactor as? LoginInteractor else {
            XCTFail("Expected interactor to be LoginInteractor")
            return
        }
        
        XCTAssertNotNil(interactor.presenter)
    }
    
    func testNavigateToRegisterPresentsRegisterViewController() {
        let mockView = MockLoginViewController()
        let router = LoginRouter()
        
        router.navigateToRegister(from: mockView)
        
        XCTAssertNotNil(mockView.presentedVC)
        XCTAssertTrue(mockView.presentedVC is RegisterViewController)
        XCTAssertEqual(mockView.presentedStyle, .formSheet)
    }
}
