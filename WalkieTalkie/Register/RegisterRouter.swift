//
//  RegisterRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class RegisterRouter: RegisterRouterProtocol {
    static func createModule() -> UIViewController {
        let view = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
