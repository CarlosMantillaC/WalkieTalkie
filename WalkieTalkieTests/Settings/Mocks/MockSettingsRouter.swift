//
//  MockSettingsRouter.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

final class MockSettingsRouter: SettingsRouterProtocol {
    var navigateToLoginCalled = false
    
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    func navigateToLogin(from view: SettingsViewProtocol?) {
        navigateToLoginCalled = true
    }
}
