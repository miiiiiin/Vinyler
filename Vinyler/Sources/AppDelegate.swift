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
//        let rootViewController = SignUpViewController()
//        let nav = NavigationController(rootViewController: rootViewController)
//        window?.rootViewController = nav
        
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
        
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        
        let viewModel = LoginViewModel(sceneCoordinator: SceneCoordinator.shared, useCase: CommonUseCaseImpl(repository: CommonService(network: VNNetworking())))
        sceneCoordinator.transition(to: Scene.login(viewModel))
        return true
    }
}
