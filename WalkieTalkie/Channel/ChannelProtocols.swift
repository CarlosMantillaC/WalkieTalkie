//
//  HomeProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelViewProtocol: AnyObject {
    func setChannelName(_ name: String)
    func displayUsers(_ text: String)
    func showDisconnectedState()
}

protocol ChannelPresenterProtocol: AnyObject {
    func viewDidLoad()
    func startTalking()
    func stopTalking()
    func didTapExit()
    func refreshUsers()
    func didTapDropdown()
    var interactor: ChannelInteractorProtocol? { get }
    func didTapDropdownCountUser()
    func didTapSettings()
}

protocol ChannelInteractorProtocol: AnyObject {
    func connectToChannel(named name: String)
    func startTalking()
    func stopTalking()
    func disconnectFromChannel()
    func fetchUsersInChannel(named channelName: String)
}

protocol ChannelInteractorOutputProtocol: AnyObject {
    func didFetchUsers(_ emails: [String])
    func didDisconnect()
}

protocol ChannelRouterProtocol: AnyObject {
    static func createModule(with channel: Channel?) -> UIViewController
    func presentChannelsModally(from view: ChannelViewProtocol)
    func navigateToChannelPrivateCreate(from view: ChannelViewProtocol)
    func navigateToSettings(from view: ChannelViewProtocol)
}
