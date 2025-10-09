//
//  ChannelPrivateCreateRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelPrivateCreateRouter: ChannelPrivateCreateRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = ChannelPrivateCreateViewController(nibName: "ChannelPrivateCreateViewController", bundle: nil)
        let presenter = ChannelPrivateCreatePresenter()
        let interactor = ChannelPrivateCreateInteractor()
        let router = ChannelPrivateCreateRouter()
        
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
