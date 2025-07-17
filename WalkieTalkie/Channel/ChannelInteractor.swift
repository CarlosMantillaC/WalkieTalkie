//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelInteractor: ChannelInteractorProtocol {
    weak var presenter: ChannelInteractorOutputProtocol?
    private let repository: LogoutRepositoryProtocol
    
    init(repository: LogoutRepositoryProtocol = LogoutRepository()) {
        self.repository = repository
    }
    
    func logout() {
        repository.logout { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    TokenManager.clear()
                    self?.presenter?.logoutSucceeded(message: message)
                case .failure(let error):
                    self?.presenter?.logoutFailed(with: error)
                }
            }
        }
    }
}
