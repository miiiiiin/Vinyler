//
//  Extensions+UIViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/17/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
