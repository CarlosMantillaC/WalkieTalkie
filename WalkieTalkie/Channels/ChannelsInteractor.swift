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
        let group = DispatchGroup()
        var publicChannels: [Channel]?
        var privateChannels: [Channel]?
        var fetchError: Error?

        group.enter()
        repository.fetchPublicChannels { result in
            switch result {
            case .success(let channels):
                publicChannels = channels
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }

        group.enter()
        repository.fetchPrivateChannels { result in
            switch result {
            case .success(let channels):
                privateChannels = channels
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = fetchError {
                self.presenter?.didFailLoadingChannels(error: error)
                return
            }
            
            guard let publicChannels = publicChannels, let privateChannels = privateChannels else {
                self.presenter?.didFailLoadingChannels(error: NSError(domain: "IncompleteData", code: -1, userInfo: nil))
                return
            }
            
            self.presenter?.didLoadChannels(publicChannels: publicChannels, privateChannels: privateChannels)
        }
    }
}
