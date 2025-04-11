//
//  SceneDelegate.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        let navigationController = UINavigationController.init(rootViewController: CharacterListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

