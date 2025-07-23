//
//  RegisterRouterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterRouterTests: XCTestCase {
    
    func testCreateModuleReturnsRegisterViewControllerWithDependencies() {
        let viewController = RegisterRouter.createModule()

        XCTAssertTrue(viewController is RegisterViewController)
        
        guard let registerVC = viewController as? RegisterViewController else {
            XCTFail("Returned view is not RegisterViewController")
            return
        }

        XCTAssertNotNil(registerVC.presenter)

        if let presenter = registerVC.presenter as? RegisterPresenter {
            XCTAssertTrue(presenter.view === registerVC)
            XCTAssertNotNil(presenter.interactor)
            XCTAssertNotNil(presenter.router)

            if let interactor = presenter.interactor as? RegisterInteractor {
                XCTAssertTrue(interactor.presenter === presenter)
            } else {
                XCTFail("Interactor is not of type RegisterInteractor")
            }
        } else {
            XCTFail("Presenter is not of type RegisterPresenter")
        }
    }
}
