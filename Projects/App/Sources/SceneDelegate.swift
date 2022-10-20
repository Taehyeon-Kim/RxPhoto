//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by taekki on 2022/10/20.
//

import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = DemoViewController()
        window?.makeKeyAndVisible()
    }
}
