//
//  ChannelPrivateCreateProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol ChannelPrivateCreateViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func show(error: String)
    func showSuccess(message: String)
}

protocol ChannelPrivateCreatePresenterProtocol: AnyObject {
    var view: ChannelPrivateCreateViewProtocol? { get set }
    var interactor: ChannelPrivateCreateInteractorInputProtocol? { get set }
    var router: ChannelPrivateCreateRouterProtocol? { get set }
    
    func createChannel()
}

protocol ChannelPrivateCreateInteractorInputProtocol: AnyObject {
    var presenter: ChannelPrivateCreateInteractorOutputProtocol? { get set }
    
    func createChannel()
}

protocol ChannelPrivateCreateInteractorOutputProtocol: AnyObject {
    func didCreateChannel()
    func didFailToCreateChannel(with error: Error)
}

protocol ChannelPrivateCreateRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func dismiss()
}
