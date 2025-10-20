//
//  ChannelsPresenter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelsPresenter {
    weak var view: ChannelsViewProtocol?
    var interactor: ChannelsInteractorProtocol?
    var router: ChannelsRouterProtocol?
    var onChannelSelected: ((Channel) -> Void)?
    private var publicChannels: [Channel] = []
    private var privateChannels: [Channel] = []
    
    private enum Section: Int, CaseIterable {
        case privateChannels
        case publicChannels
    }
}

extension ChannelsPresenter: ChannelsPresenterProtocol {
    var numberOfSections: Int {
        return Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .privateChannels:
            return privateChannels.count
        case .publicChannels:
            return publicChannels.count
        }
    }
    
    func titleForHeader(in section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        switch section {
        case .privateChannels:
            return "Canales Privados"
        case .publicChannels:
            return "Canales Públicos"
        }
    }

    func viewDidLoad() {
        interactor?.loadChannels()
    }
    
    func configure(cell: ChannelsTableViewCell, at indexPath: IndexPath) {
        let channel = channel(at: indexPath)
        cell.customLabel.text = channel.name
        cell.customImageView.image = UIImage(systemName: "dot.radiowaves.left.and.right")
    }
    
    func didSelectChannel(at indexPath: IndexPath) {
        let selectedChannel = channel(at: indexPath)
        onChannelSelected?(selectedChannel)
    }
    
    func joinChannelTapped() {
        router?.navigateToJoinChannel()
    }
    
    func createChannelTapped() {
        router?.navigateToCreateChannel()
    }
    
    private func channel(at indexPath: IndexPath) -> Channel {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }
        
        switch section {
        case .privateChannels:
            return privateChannels[indexPath.row]
        case .publicChannels:
            return publicChannels[indexPath.row]
        }
    }
}

extension ChannelsPresenter: ChannelsInteractorOutput {
    func didLoadChannels(publicChannels: [Channel], privateChannels: [Channel]) {
        self.publicChannels = publicChannels
        self.privateChannels = privateChannels
        view?.reloadData()
    }

    func didFailLoadingChannels(error: Error) {
        view?.showError(message: error.localizedDescription)
    }
}
