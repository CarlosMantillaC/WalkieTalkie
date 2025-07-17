//
//  ChannelsProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelsViewProtocol: AnyObject {
    func reloadData()
    func showError(message: String)
}

protocol ChannelsPresenterProtocol: AnyObject {
    var channelsCount: Int { get }
    func viewDidLoad()
    func configure(cell: ChannelsTableViewCell, at index: Int)
    func didSelectChannel(at index: Int)
}

protocol ChannelsInteractorProtocol: AnyObject {
    func loadChannels()
}

protocol ChannelsInteractorOutput: AnyObject {
    func didLoadChannels(_ channels: [Channel])
    func didFailLoadingChannels(error: Error)
}

protocol ChannelsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToChannel(with channel: Channel)
}
