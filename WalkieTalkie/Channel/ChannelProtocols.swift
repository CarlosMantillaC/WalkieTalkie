//
//  HomeProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelViewProtocol: AnyObject {
    func setChannelName(_ name: String)
}

protocol ChannelPresenterProtocol: AnyObject {
    func viewDidLoad()
    func startTalking()
    func stopTalking()
    func didTapExit()
}

protocol ChannelInteractorProtocol: AnyObject {
    func connectToChannel(named name: String)
    func startTalking()
    func stopTalking()
    func disconnectFromChannel()
}

protocol ChannelInteractorOutputProtocol: AnyObject {
    func didReceivePermissionToSpeak()
}

protocol ChannelRouterProtocol: AnyObject {
    static func createModule(with channel: Channel) -> UIViewController
    func navigateToChannels()
}
