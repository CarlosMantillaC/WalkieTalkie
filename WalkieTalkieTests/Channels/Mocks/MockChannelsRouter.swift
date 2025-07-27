//
//  MockChannelsRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsRouter: ChannelsRouterProtocol {
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    var navigatedChannel: Channel?
    var logoutMessage: String?

    func navigateToChannel(from view: ChannelsViewProtocol, with channel: Channel) {
        navigatedChannel = channel
    }

    func navigateToLogin(with message: String) {
        logoutMessage = message
    }
}
