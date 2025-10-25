//
//  ListUsersProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ListUsersViewProtocol: AnyObject {
    func reloadData()
    func showError(message: String)
}

protocol ListUsersPresenterProtocol: AnyObject {
    var interactor: ListUsersInteractorInputProtocol? { get set }
    var view: ListUsersViewProtocol? { get set }
    var router: ListUsersRouterProtocol? { get set }

    func viewDidLoad()
    func numberOfRows() -> Int
    func user(at indexPath: IndexPath) -> String
    func configure(cell: ListUsersTableViewCell, at indexPath: IndexPath)
}

protocol ListUsersInteractorInputProtocol: AnyObject {
    var presenter: ListUsersInteractorOutputProtocol? { get set }
    func fetchUsers()
}

protocol ListUsersInteractorOutputProtocol: AnyObject {
    func didFetchUsers(_ users: [String])
    func didFailToFetchUsers(with error: Error)
}

protocol ListUsersRouterProtocol: AnyObject {
    static func createModule(with channelName: String) -> UIViewController
}
