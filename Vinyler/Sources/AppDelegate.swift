//
//  AppDelegate.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
//        let rootViewController = MainViewController()
//        let rootViewController = SplashViewController()
//        let nav = NavigationController(rootViewController: rootViewController)

        window?.makeKeyAndVisible()
        
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        let viewModel = HomeViewModel(sceneCoordinator: sceneCoordinator)
        sceneCoordinator.transition(to: Scene.home(viewModel))

        return true
    }
}
