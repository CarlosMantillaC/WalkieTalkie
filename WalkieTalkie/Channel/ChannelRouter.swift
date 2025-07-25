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
        
    func navigateToChannels(from view: ChannelViewProtocol) {
        let channelsVC = ChannelsRouter.createModule()
        if let vc = view as? UIViewController {
            vc.navigationController?.setViewControllers([channelsVC], animated: true)
        }
    }
}
