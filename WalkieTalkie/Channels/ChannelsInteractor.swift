//
//  ChannelsInteractor.swift
//  WalkieTalkie
//

//

import Foundation

class ChannelsInteractor {
    weak var presenter: ChannelsInteractorOutput?
    private let repository: ChannelsRepositoryProtocol
    
    init(repository: ChannelsRepositoryProtocol = ChannelsRepository()) {
        self.repository = repository
    }
}

extension ChannelsInteractor: ChannelsInteractorProtocol {
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
}
