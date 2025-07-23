//
//  MockRegisterRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockRegisterRouter: RegisterRouterProtocol {
    static func createModule() -> UIViewController {
        return UIViewController()
    }
}
