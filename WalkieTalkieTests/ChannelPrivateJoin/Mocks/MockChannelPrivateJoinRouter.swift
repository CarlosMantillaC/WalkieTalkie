//
//  MockChannelPrivateJoinRouter.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

class MockChannelPrivateJoinRouter: ChannelPrivateJoinRouterProtocol {
    var dismissCalled = false

    static func createModule() -> UIViewController {
        return UIViewController()
    }

    func dismiss() {
        dismissCalled = true
    }
}
