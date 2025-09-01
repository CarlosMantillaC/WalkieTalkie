//
//  MockChannelRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelRouter: ChannelRouterProtocol {
    var presentModalCalled = false
    var lastMessage: String?
    var navigateCalled = false

    static func createModule(with channel: WalkieTalkie.Channel?) -> UIViewController {
        return UIViewController()
    }
        
    func presentChannelsModally(from view: ChannelViewProtocol) {
        presentModalCalled = true
    }

    func navigateToLogin(with message: String) {
        navigateCalled = true
        lastMessage = message
    }
}
