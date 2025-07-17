//
//  HomeRouter.swift
//  WalkieTalkie
//

//

import UIKit

final class ChannelRouter: ChannelRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(with channel: Channel) -> UIViewController {
        let view = ChannelViewController(nibName: "ChannelViewController", bundle: nil)
        let presenter = ChannelPresenter(channel: channel)
        let interactor = ChannelInteractor(channel: channel)
        let router = ChannelRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
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
    
    func navigateToChannels() {
        print("saliendo a canales")
        let channelsVC = ChannelsRouter.createModule()
        viewController?.navigationController?.setViewControllers([channelsVC], animated: true)
    }
}
