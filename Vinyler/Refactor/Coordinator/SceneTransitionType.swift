//
//  SceneTransitionType.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    case root(UIViewController)
    case push(UIViewController)
    case present(UIViewController)
    case alert(UIViewController)
    case tabBar(UITabBarController)
}
