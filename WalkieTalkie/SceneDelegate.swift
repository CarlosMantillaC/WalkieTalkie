//
//  SceneDelegate.swift
//  WalkieTalkie
//

//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let initialViewController: UIViewController
        
        if let token = TokenManager.accessToken, !token.isEmpty {
            print("Token detectado al iniciar la app:", token)
            initialViewController = ChannelRouter.createModule()
        } else {
            print("No hay token al iniciar la app")
            initialViewController = LoginRouter.createModule()
        }
        
        let navController = UINavigationController(rootViewController: initialViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.fromHex("#4b0082")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        
        self.window?.makeKeyAndVisible()
    }
}
