//
//  SceneDelegate.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = CardBoardViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}

