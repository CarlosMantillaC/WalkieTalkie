//
//  ChannelPrivateJoinRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelPrivateJoinRouter: ChannelPrivateJoinRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = ChannelPrivateJoinViewController(nibName: "ChannelPrivateJoinViewController", bundle: nil)
        let presenter = ChannelPrivateJoinPresenter()
        let interactor = ChannelPrivateJoinInteractor()
        let router = ChannelPrivateJoinRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
