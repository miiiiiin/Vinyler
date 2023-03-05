//
//  Extensions+UIViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit

extension UIViewController {

    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
}
