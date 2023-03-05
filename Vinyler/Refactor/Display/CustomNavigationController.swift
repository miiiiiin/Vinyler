//
//  CustomNavigationController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    // MARK: Properties
    
    private var sceneCoordiantor: SceneCoordinatorType!
    
    // MARK: Init

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(rootViewController: UIViewController,
        sceneCoordiantor: SceneCoordinatorType = SceneCoordinator.shared) {
        super.init(rootViewController: rootViewController)
        self.sceneCoordiantor = sceneCoordiantor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }
}
