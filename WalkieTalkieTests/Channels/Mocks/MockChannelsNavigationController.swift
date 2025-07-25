//
//  MockChannelsNavigationController.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

final class MockChannelsNavigationController: UINavigationController {
    var didSetViewControllers = false
    var setViewControllersCalledWith: [UIViewController]?

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        didSetViewControllers = true
        setViewControllersCalledWith = viewControllers
        super.setViewControllers(viewControllers, animated: animated)
    }
}
