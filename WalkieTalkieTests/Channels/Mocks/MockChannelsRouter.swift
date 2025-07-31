//
//  MockChannelsRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsRouter: ChannelsRouterProtocol {
    var navigatedChannel: Channel?
    var logoutMessage: String?

    static func createModule(onChannelSelected: @escaping (WalkieTalkie.Channel) -> Void) -> UIViewController {
        return UIViewController()
    }

    func navigateToChannel(from view: ChannelsViewProtocol, with channel: Channel) {
        navigatedChannel = channel
    }

    func navigateToLogin(with message: String) {
        logoutMessage = message
    }
}
