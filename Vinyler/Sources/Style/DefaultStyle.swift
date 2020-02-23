//
//  DefaultStyle.swift
//  Vinyler
//
//  Created by Min on 2020/02/23.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import Foundation
import UIKit

public enum DefaultStyle {

    public enum Colors {
        public static let label: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return .black
            }
        }()
        
        public static var tint: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        /// Return the color for Dark Mode
                        return UIColor.white
                    } else {
                        /// Return the color for Light Mode
                        return UIColor.black
                    }
                }
            } else {
                /// Return a fallback color for iOS 12 and lower.
                return UIColor.black
            }
        }()
    }
}

public let style = DefaultStyle.self
