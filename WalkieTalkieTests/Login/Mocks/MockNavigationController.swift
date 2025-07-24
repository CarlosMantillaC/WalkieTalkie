//
//  MockNavigationController.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockNavigationController: UINavigationController {
    var lastPushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
