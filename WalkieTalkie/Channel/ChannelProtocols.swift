//
//  HomeProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelViewProtocol: AnyObject {
    func setChannelName(_ name: String)
    func displayUsers(_ emails: [String])
}

protocol ChannelPresenterProtocol: AnyObject {
    func didTapLogout()
    func viewDidLoad()
    func startTalking()
    func stopTalking()
    func didTapExit()
    func refreshUsers()
    func didTapDropdown()
    var interactor: ChannelInteractorProtocol? { get }
}

protocol ChannelInteractorProtocol: AnyObject {
    func logout()
    func connectToChannel(named name: String)
    func startTalking()
    func stopTalking()
    func disconnectFromChannel()
    func fetchUsersInChannel(named channelName: String)
}

protocol ChannelInteractorOutputProtocol: AnyObject {
    func logoutSucceeded(message: String)
    func didFetchUsers(_ emails: [String])
}

protocol ChannelRouterProtocol: AnyObject {
    static func createModule(with channel: Channel?) -> UIViewController
    func presentChannelsModally(from view: ChannelViewProtocol)
    func navigateToLogin(with message: String)
}
