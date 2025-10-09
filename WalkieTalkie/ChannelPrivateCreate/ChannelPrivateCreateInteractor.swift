//
//  ChannelPrivateCreateInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateCreateInteractor: ChannelPrivateCreateInteractorInputProtocol {
    weak var presenter: ChannelPrivateCreateInteractorOutputProtocol?
    private let repository: ChannelsRepositoryProtocol
    
    init(repository: ChannelsRepositoryProtocol = ChannelsRepository()) {
        self.repository = repository
    }
    
    func createChannel() {
    }
}
