//
//  SettingsRouter.swift
//  WalkieTalkie
//

//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
    static func createModule() -> UIViewController {
        let view = SettingsViewController()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        let router: SettingsRouterProtocol = SettingsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToLogin(from view: SettingsViewProtocol?) {
        let loginVC = LoginRouter.createModule()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = scene.delegate as? SceneDelegate {
            delegate.window?.rootViewController = navController
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let alert = UIAlertController(
                    title: "Sesión cerrada",
                    message: "Sesión cerrada exitosamente",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                navController.present(alert, animated: true)
            }
        }
    }
}
