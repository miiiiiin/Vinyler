//
//  AppDelegate.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import GoogleMobileAds
import KakaoSDKCommon
import KakaoSDKAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        KakaoSDK.initSDK(appKey: "e381b7502a2619e0b0fe0ce5ec44899d")
        GADMobileAds.sharedInstance().start(completionHandler: nil)

//        let rootViewController = MainViewController()
//        let rootViewController = SignUpViewController()
//        let nav = NavigationController(rootViewController: rootViewController)
//        window?.rootViewController = nav
        
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
        
        
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        SceneCoordinator.shared = sceneCoordinator
        
        let viewModel = SignUpViewModel(sceneCoordinator: SceneCoordinator.shared, useCase: SignUpUseCaseImpl(repository: UserSignUpService(network: VNNetworking())))
        sceneCoordinator.transition(to: Scene.signUp(viewModel))
        return true
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        if let url = userActivity.webpageURL {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                return AuthController.handleOpenUrl(url: url)
            }
        }
        return false
    }
}

