//
//  ListUsersRouter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ListUsersRouter: ListUsersRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(with channelName: String) -> UIViewController {
        let view = ListUsersViewController(nibName: "ListUsersViewController", bundle: nil)
        let presenter = ListUsersPresenter()
        let interactor = ListUsersInteractor(channelName: channelName)
        let router = ListUsersRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
