//
//  ChannelsRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelsRouter: ChannelsRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(onChannelSelected: @escaping (Channel) -> Void) -> UIViewController {
        let view = ChannelsViewController()
        let presenter = ChannelsPresenter()
        let interactor = ChannelsInteractor()
        let router = ChannelsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        presenter.onChannelSelected = onChannelSelected
        
        return view
    }
    
    func navigateToJoinChannel() {
        let alert = UIAlertController(title: "Unirse a Canal", message: "Esta funcionalidad todavía no está implementada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }
    
    func navigateToCreateChannel() {
        let createChannelVC = ChannelPrivateCreateRouter.createModule()
        viewController?.present(createChannelVC, animated: true)
    }
}
