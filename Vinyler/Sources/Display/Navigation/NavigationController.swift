//
//  NavigationController.swift
//  Vinyler
//
//  Created by 민송경 on 15/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    let navigationControllerDelegate = NavigationControllerDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        delegate = navigationControllerDelegate
        isNavigationBarHidden = true
    }
}
