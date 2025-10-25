//
//  ChannelPrivateJoinInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateJoinInteractor: ChannelPrivateJoinInteractorInputProtocol {
    weak var presenter: ChannelPrivateJoinInteractorOutputProtocol?
    private let repository: ChannelPrivateJoinRepositoryProtocol
    
    init(repository: ChannelPrivateJoinRepositoryProtocol = ChannelPrivateJoinRepository()) {
        self.repository = repository
    }
    
    func joinChannel(name: String, pin: String) {
        let request = ChannelPrivateJoinRequest(name: name, pin: pin)
        repository.joinChannel(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.presenter?.didJoinChannel(response: response)
                case .failure(let error):
                    self?.presenter?.didFailToJoinChannel(with: error)
                }
            }
        }
    }
}
