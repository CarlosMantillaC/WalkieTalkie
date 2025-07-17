//
//  ChannelsInteractor.swift
//  WalkieTalkie
//

//

import Foundation

class ChannelsInteractor: ChannelsInteractorProtocol {
    weak var presenter: ChannelsInteractorOutput?
    private let repository: ChannelsRepositoryProtocol
    private let repositoryLogout: LogoutRepositoryProtocol

    init(repository: ChannelsRepositoryProtocol = ChannelsRepository(), repositoryLogout: LogoutRepositoryProtocol = LogoutRepository() ) {
        self.repository = repository
        self.repositoryLogout = repositoryLogout
    }

    func loadChannels() {
        repository.fetchChannels { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let channels):
                    self?.presenter?.didLoadChannels(channels)
                case .failure(let error):
                    self?.presenter?.didFailLoadingChannels(error: error)
                }
            }
        }
    }
    
    func logout() {
        repositoryLogout.logout { [weak self] result in
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
