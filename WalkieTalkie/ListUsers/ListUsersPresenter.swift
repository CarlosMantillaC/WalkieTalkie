//
//  ListUsersPresenter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ListUsersPresenter: ListUsersPresenterProtocol {
    weak var view: ListUsersViewProtocol?
    var interactor: ListUsersInteractorInputProtocol?
    var router: ListUsersRouterProtocol?
    private var users: [String] = []
    
    func viewDidLoad() {
        interactor?.fetchUsers()
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func user(at indexPath: IndexPath) -> String {
        return users[indexPath.row]
    }
    
    func configure(cell: ListUsersTableViewCell, at indexPath: IndexPath) {
        let user = users[indexPath.row]
        cell.nameLabel.text = user
        cell.customImageView.image = UIImage(systemName: "person.fill")
    }
}

extension ListUsersPresenter: ListUsersInteractorOutputProtocol {
    func didFetchUsers(_ users: [String]) {
        self.users = users
        view?.reloadData()
    }
    
    func didFailToFetchUsers(with error: Error) {
        view?.showError(message: error.localizedDescription)
    }
}
