//
//  Extensions+UIFont.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/10.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func regularFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "HoltwoodOneSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
