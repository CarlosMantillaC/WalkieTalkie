//
//  MockChannelPrivateCreateRouter.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

class MockChannelPrivateCreateRouter: ChannelPrivateCreateRouterProtocol {
    var dismissCalled = false

    static func createModule() -> UIViewController {
        return UIViewController()
    }

    func dismiss() {
        dismissCalled = true
    }
}
