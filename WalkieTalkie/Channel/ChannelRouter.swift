//
//  HomeRouter.swift
//  WalkieTalkie
//

//

import UIKit

final class ChannelRouter: ChannelRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(with channel: Channel? = nil) -> UIViewController {
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
    
    func presentChannelsModally(from view: ChannelViewProtocol) {
        let channelsVC = ChannelsRouter.createModule { [weak self] selectedChannel in
            self?.replaceCurrentChannel(with: selectedChannel)
        }
        
        let navController = UINavigationController(rootViewController: channelsVC)
        navController.modalPresentationStyle = .pageSheet
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        if let viewController = view as? UIViewController {
            viewController.present(navController, animated: true)
        }
    }
    
    private func replaceCurrentChannel(with channel: Channel) {
        if let currentVC = viewController as? ChannelViewController,
           let interactor = currentVC.presenter?.interactor {
            interactor.disconnectFromChannel()
        }
        viewController?.presentedViewController?.dismiss(animated: true)
        
        let newChannelVC = ChannelRouter.createModule(with: channel)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
           let navController = keyWindow.rootViewController as? UINavigationController {
            navController.setViewControllers([newChannelVC], animated: false)
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

    func navigateToChannelPrivateCreate(from view: ChannelViewProtocol) {
        let channelPrivateCreateVC = ChannelPrivateCreateRouter.createModule()
        if let vc = view as? UIViewController {
            vc.navigationController?.setViewControllers([channelPrivateCreateVC], animated: true)
        }
    }
}
