//
//  AppDelegate.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        let rootViewController = MainViewController()
        let nav = NavigationController(rootViewController: rootViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }
}
