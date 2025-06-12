//
//  Extension+UIImageView.swift
//  Vinyler
//
//  Created by Min on 15/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func constraintKeepRatio(of image: UIImage) -> NSLayoutConstraint {
        let multiplier = image.size.width/image.size.height
        let ratio = widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier)
        ratio.isActive = true
        return ratio
    }
    
    static var menu: UIImageView {
        let imgView = UIImageView(forAutoLayout: ())
        imgView.tintColor = style.Colors.tint
        imgView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive = true
        return imgView
    }
}
