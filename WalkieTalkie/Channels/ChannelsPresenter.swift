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

    private var channels: [Channel] = []
}

extension ChannelsPresenter: ChannelsPresenterProtocol {
    var channelsCount: Int {
        return channels.count
    }

    func viewDidLoad() {
        interactor?.loadChannels()
    }
    
    func configure(cell: ChannelsTableViewCell, at index: Int) {
        let channel = channels[index]
        cell.customLabel.text = channel.name
        cell.customImageView.image = UIImage(systemName: "dot.radiowaves.left.and.right")
    }
    
    func didSelectChannel(at index: Int) {
        let channel = channels[index]
        router?.navigateToChannel(with: channel)
    }
    
    func didTapLogout() {
        interactor?.logout()
    }
}

extension ChannelsPresenter: ChannelsInteractorOutput {
    func logoutSucceeded(message: String) {
        router?.navigateToLogin(with: message)
    }

    func didLoadChannels(_ channels: [Channel]) {
        self.channels = channels
        view?.reloadData()
    }

    func didFailLoadingChannels(error: Error) {
        view?.showError(message: error.localizedDescription)
    }
}
