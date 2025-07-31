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
}
