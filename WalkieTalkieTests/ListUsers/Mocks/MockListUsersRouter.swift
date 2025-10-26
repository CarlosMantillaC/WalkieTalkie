//
//  MockListUsersRouter.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

class MockListUsersRouter: ListUsersRouterProtocol {
    static func createModule(with channelName: String) -> UIViewController {
        return UIViewController()
    }
}
