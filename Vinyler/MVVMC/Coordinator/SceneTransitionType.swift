//
//  SceneTransitionType.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    case root(UIViewController)
    case push(UIViewController)
    case present(UIViewController, Bool)
    case alert(UIViewController)
    case tabBar(UITabBarController)
}
