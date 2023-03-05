//
//  Scene.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit
import SafariServices

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case main(_ : Int)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
            
        case let .main(tabIndex):
            
            let tabBarController = CustomTabBarController()
            
            /// MainVC
            var mainVC = MainViewController()
            let rootVC = CustomNavigationController(rootViewController: mainVC)
            
            let mainTabBarItem = UITabBarItem(
                title: "메인",
                image: #imageLiteral(resourceName: "loader"),
                selectedImage: #imageLiteral(resourceName: "loader")
            )
            mainTabBarItem.tag = 1
            rootVC.tabBarItem = mainTabBarItem
            
            /// SearchVC
//            var searchVC = CustomNavigationController(rootViewController: SearchController())
//            let searchTabBarItem = UITabBarItem(
//                title: "검색",
//                image: #imageLiteral(resourceName: "cancel"),
//                selectedImage: #imageLiteral(resourceName: "info")
//            )
//
//            searchTabBarItem.tag = 2
//            searchVC.tabBarItem = searchTabBarItem
            
            /// SettingsVC
            var settingsVC = AppInfoViewController()
            let settingsTabBarItem = UITabBarItem(
                title: "설정",
                image: #imageLiteral(resourceName: "cancel"),
                selectedImage: #imageLiteral(resourceName: "info")
            )

            settingsTabBarItem.tag = 0
            settingsVC.tabBarItem = settingsTabBarItem
            
            tabBarController.viewControllers = [
                settingsVC,
                rootVC
//                searchVC
            ]
            tabBarController.selectedIndex = tabIndex
            
            return .tabBar(tabBarController)
        }
    }
}
