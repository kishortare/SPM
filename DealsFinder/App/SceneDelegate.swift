//
//  SceneDelegate.swift
//  DealsFinder
//
//  Created by DealsFinder Team
//  Copyright © 2025 DealsFinder. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        // Create tab bar controller
        let tabBarController = UITabBarController()

        // Deals tab
        let dealsVC = DealsListViewController()
        let dealsNav = UINavigationController(rootViewController: dealsVC)
        dealsNav.tabBarItem = UITabBarItem(title: "Deals", image: UIImage(systemName: "tag.fill"), tag: 0)

        // Categories tab
        let categoriesVC = CategoriesViewController()
        let categoriesNav = UINavigationController(rootViewController: categoriesVC)
        categoriesNav.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 1)

        // Favorites tab
        let favoritesVC = FavoritesViewController()
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)

        tabBarController.viewControllers = [dealsNav, categoriesNav, favoritesNav]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
