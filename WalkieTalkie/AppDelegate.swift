//
//  AppDelegate.swift
//  WalkieTalkie
//

//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var restrictRotationToPortrait = false
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if restrictRotationToPortrait {
            return .portrait
        }
        return .all
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

