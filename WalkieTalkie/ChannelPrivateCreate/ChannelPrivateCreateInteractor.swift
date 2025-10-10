//
//  ChannelPrivateCreateInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateCreateInteractor: ChannelPrivateCreateInteractorInputProtocol {
    weak var presenter: ChannelPrivateCreateInteractorOutputProtocol?
    private let repository: ChannelPrivateCreateRepositoryProtocol
    
    init(repository: ChannelPrivateCreateRepositoryProtocol = ChannelPrivateCreateRepository()) {
        self.repository = repository
    }
    
    func createChannel(name: String, pin: String) {
        let request = ChannelPrivateCreateRequest(name: name, pin: pin)
        repository.createChannel(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.presenter?.didCreateChannel()
                case .failure(let error):
                    self?.presenter?.didFailToCreateChannel(with: error)
                }
            }
        }
    }
}
