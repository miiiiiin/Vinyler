//
//  UIFont+Style.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UIFont {

//    static func regularFont(with size: CGFloat) -> UIFont? {
//        return UIFont(name: "AvenirNext-Regular", size: size)
//    }

    static func regularFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Holtwood One SC", size: size)
    }
    
    static func demiBoldFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-DemiBold", size: size)
    }

    static func boldFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-Bold", size: size)
    }

    static func mediumFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-Medium", size: size)
    }

    static func timesFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "TimesNewRomanPSMT", size: size)
    }

    static var block = UIFont.demiBoldFont(with: 40)
    static var header = UIFont.regularFont(with: 24)
    static var headerBold = UIFont.demiBoldFont(with: 24)
    static var headerTimes = UIFont.timesFont(with: 28)
    static var header2 = UIFont.mediumFont(with: 20)
    static var subheader = UIFont.regularFont(with: 16)
    static var body = UIFont.regularFont(with: 16)
    static var bodyBold = UIFont.demiBoldFont(with: 16)
    static var metadata = UIFont.boldFont(with: 14)
    static var position = UIFont.mediumFont(with: 14)
}
