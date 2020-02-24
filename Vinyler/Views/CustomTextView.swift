//
//  CustomTextView.swift
//  Vinyler
//
//  Created by Min on 2020/01/25.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UIView {
    
    let titleLbl = UILabel.header2
    let bodyLbl = UITextView.body
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        titleLbl.textColor = style.Colors.tint
        bodyLbl.textColor = style.Colors.tint
        
        
        [titleLbl, bodyLbl].forEach(addSubview(_:))
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bodyLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 18).isActive = true
        bodyLbl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bodyLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bodyLbl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
