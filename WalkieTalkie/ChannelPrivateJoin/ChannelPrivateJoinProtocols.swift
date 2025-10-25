//
//  ChannelPrivateJoinProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelPrivateJoinViewProtocol: AnyObject {
    func showError(error: String)
    func showSuccess(message: String)
}

protocol ChannelPrivateJoinPresenterProtocol: AnyObject {
    var view: ChannelPrivateJoinViewProtocol? { get set }
    var interactor: ChannelPrivateJoinInteractorInputProtocol? { get set }
    var router: ChannelPrivateJoinRouterProtocol? { get set }
    
    func joinChannel(name: String, pin: String)
}

protocol ChannelPrivateJoinInteractorInputProtocol: AnyObject {
    var presenter: ChannelPrivateJoinInteractorOutputProtocol? { get set }
    
    func joinChannel(name: String, pin: String)
}

protocol ChannelPrivateJoinInteractorOutputProtocol: AnyObject {
    func didJoinChannel(response: ChannelPrivateJoinResponse)
    func didFailToJoinChannel(with error: Error)
}

protocol ChannelPrivateJoinRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func dismiss()
}
