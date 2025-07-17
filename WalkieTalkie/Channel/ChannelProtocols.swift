//
//  HomeProtocols.swift
//  WalkieTalkie
//

//

import Foundation

protocol ChannelViewProtocol: AnyObject {
    func showLogoutError(_ message: String)
}

protocol ChannelPresenterProtocol: AnyObject {
    func didTapLogout()
}

protocol ChannelInteractorProtocol: AnyObject {
    func logout()
}

protocol ChannelInteractorOutputProtocol: AnyObject {
    func logoutSucceeded(message: String)
    func logoutFailed(with error: Error)
}

protocol ChannelRouterProtocol: AnyObject {
    func navigateToLogin(with message: String)
}
