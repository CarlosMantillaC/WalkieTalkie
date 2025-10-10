//
//  ChannelPrivateCreateProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelPrivateCreateViewProtocol: AnyObject {
    func showError(error: String)
    func showSuccess(message: String)
}

protocol ChannelPrivateCreatePresenterProtocol: AnyObject {
    var view: ChannelPrivateCreateViewProtocol? { get set }
    var interactor: ChannelPrivateCreateInteractorInputProtocol? { get set }
    var router: ChannelPrivateCreateRouterProtocol? { get set }
    
    func createChannel(name: String, pin: String)
}

protocol ChannelPrivateCreateInteractorInputProtocol: AnyObject {
    var presenter: ChannelPrivateCreateInteractorOutputProtocol? { get set }
    
    func createChannel(name: String, pin: String)
}

protocol ChannelPrivateCreateInteractorOutputProtocol: AnyObject {
    func didCreateChannel()
    func didFailToCreateChannel(with error: Error)
}

protocol ChannelPrivateCreateRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func dismiss()
}
