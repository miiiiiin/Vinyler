//
//  PresentLoadingAnimationController.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

class PresentLoadingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromNC = transitionContext.viewController(forKey: .from) as? UINavigationController,
            let fromVC = fromNC.topViewController as? ScanViewController,
            let toNC = transitionContext.viewController(forKey: .to) as? UINavigationController,
            let toVC = toNC.viewControllers.first as? LoadingViewController,
            let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
                return
        }
        
        fromVC.view.isHidden = true
        transitionContext.containerView.addSubview(toNC.view)
        toVC.activityIndicatorCenterY.constant = -66
        toVC.activityIndicatorView.alpha = 0
        toNC.view.layoutIfNeeded()
        
        transitionContext.containerView.addSubview(fromSnapshot)
        
        fromSnapshot.frame = fromVC.view.frame
        
        let yTranslation = fromVC.view.frame.height
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            fromSnapshot.transform = CGAffineTransform(translationX: 0, y: yTranslation)
        }){ _ in
            fromVC.view.isHidden = false
            fromSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        toVC.activityIndicatorCenterY.constant = 0
        UIView.animate(withDuration: duration/2, delay: duration/2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            toVC.view.layoutIfNeeded()
            toVC.activityIndicatorView.alpha = 1
        })
    }
}

