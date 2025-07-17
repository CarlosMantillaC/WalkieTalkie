//
//  ChannelsRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelsRouter: ChannelsRouterProtocol {
    
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
        
        return view
    }
}
