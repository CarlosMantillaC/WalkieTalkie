//
//  ChannelsRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelsRouter: ChannelsRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = ChannelsViewController(nibName: "ChannelsViewController", bundle: nil)
        let presenter = ChannelsPresenter()
        let interactor = ChannelsInteractor()
        let router = ChannelsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view

        return view
    }

    func navigateToChannel(from view: ChannelsViewProtocol, with channel: Channel) {
        let channelVC = ChannelRouter.createModule(with: channel)

        if let viewController = view as? UIViewController,
           let navController = viewController.navigationController {
            navController.setViewControllers([channelVC], animated: true)
        }
    }
    
    func navigateToLogin(with message: String) {
        let loginVC = LoginRouter.createModule()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = scene.delegate as? SceneDelegate {
            delegate.window?.rootViewController = navController
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let alert = UIAlertController(
                    title: "Sesión cerrada",
                    message: message,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                navController.present(alert, animated: true)
            }
        }
    }
}
    
