//
//  CustomTabBarController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UITabBarItem Appearance -
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [CustomTabBarController.self])
        appearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldFont(with: 12)], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -7)
        
        UITabBar.appearance().tintColor = .gray
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        
        // MARK: - Custom TabBar Top Border -
        
        self.tabBar.clipsToBounds = true
        self.tabBar.barTintColor = .blue
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        lineView.backgroundColor = UIColor.green
        self.tabBar.addSubview(lineView)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class CustomTabBar: UITabBar {
        override open func sizeThatFits(_ size: CGSize) -> CGSize {
            super.sizeThatFits(size)
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = CGFloat.defaultHeight //+ UIApplication.safeAreaInsets.bottom
            return sizeThatFits
        }
    }
}
