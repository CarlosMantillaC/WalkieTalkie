//
//  ChannelsPresenter.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

final class ChannelsPresenter: ChannelsPresenterProtocol {
    weak var view: ChannelsViewProtocol?
    var interactor: ChannelsInteractorProtocol?
    var router: ChannelsRouterProtocol?

    private var channels: [Channel] = []

    func viewDidLoad() {
        interactor?.loadChannels()
    }

    var channelsCount: Int {
        return channels.count
    }

    func configure(cell: ChannelsTableViewCell, at index: Int) {
        let channel = channels[index]
        cell.customLabel.text = channel.name
        cell.customImageView.image = UIImage(systemName: "dot.radiowaves.left.and.right")
    }
}

extension ChannelsPresenter: ChannelsInteractorOutput {
    func didLoadChannels(_ channels: [Channel]) {
        self.channels = channels
        view?.reloadData()
    }

    func didFailLoadingChannels(error: Error) {
        view?.showError(message: error.localizedDescription)
    }
}
