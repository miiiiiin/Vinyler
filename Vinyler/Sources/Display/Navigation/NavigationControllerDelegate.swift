//
//  NavigationControllerDelegate.swift
//  Vinyler
//
//  Created by 민송경 on 15/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isKind(of: MainViewController.self),
            toVC.isKind(of: ScanViewController.self) {
//            return PresentScanAnimationController()
        } else if fromVC.isKind(of: ScanViewController.self),
            toVC.isKind(of: MainViewController.self) {
//            return DismissScanAnimationController()
        }
        return nil
    }

}
