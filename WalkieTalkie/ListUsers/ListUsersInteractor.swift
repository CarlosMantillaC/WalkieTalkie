//
//  ListUsersInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ListUsersInteractor: ListUsersInteractorInputProtocol {
    weak var presenter: ListUsersInteractorOutputProtocol?
    private let repository: ListUsersRepositoryProtocol
    private let channelName: String
    
    init(channelName: String, repository: ListUsersRepositoryProtocol = ListUsersRepository()) {
        self.channelName = channelName
        self.repository = repository
    }
    
    func fetchUsers() {
        repository.fetchUsers(for: channelName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.presenter?.didFetchUsers(users)
                case .failure(let error):
                    self?.presenter?.didFailToFetchUsers(with: error)
                }
            }
        }
    }
}
