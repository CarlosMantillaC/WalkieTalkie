//
//  LoginRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class LoginRouter: LoginRouterProtocol {
    static func createModule() -> UIViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToHome(from view: LoginViewProtocol) {
        let homeVC = ChannelRouter.createModule()
        if let vc = view as? UIViewController {
            vc.navigationController?.setViewControllers([homeVC], animated: true)
        }
    }
    
    func navigateToRegister(from view: LoginViewProtocol) {
        let registerVC = RegisterRouter.createModule()
        registerVC.modalPresentationStyle = .formSheet
        
        if let vc = view as? UIViewController {
            vc.present(registerVC, animated: true)
        }
    }
}
