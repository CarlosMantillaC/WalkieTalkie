//
//  MockChannelRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelRouter: ChannelRouterProtocol {
    var navigateCalled = false

    static func createModule(with channel: WalkieTalkie.Channel) -> UIViewController {
        return UIViewController()
    }
    
    func navigateToChannels(from view: ChannelViewProtocol) {
        navigateCalled = true
    }
}
