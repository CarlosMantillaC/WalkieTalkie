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
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func titleForHeader(in section: Int) -> String?
    func viewDidLoad()
    func configure(cell: ChannelsTableViewCell, at indexPath: IndexPath)
    func didSelectChannel(at indexPath: IndexPath)
    func joinChannelTapped()
    func createChannelTapped()
}

protocol ChannelsInteractorProtocol: AnyObject {
    func loadChannels()
}

protocol ChannelsInteractorOutput: AnyObject {
    func didLoadChannels(publicChannels: [Channel], privateChannels: [Channel])
    func didFailLoadingChannels(error: Error)
}

protocol ChannelsRouterProtocol: AnyObject {
    static func createModule(onChannelSelected: @escaping (Channel) -> Void) -> UIViewController
    func navigateToJoinChannel()
    func navigateToCreateChannel()
}
