//
//  UITextfield+Style.swift
//  Vinyler
//
//  Created by Min on 2019/12/07.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UITextField {
    
    static var standard: UITextField = {
        let textField = CustomTextfield(forAutoLayout: ())
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.font = UIFont.body
        textField.textColor = style.Colors.tint
        textField.tintColor = .gray
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .search
        let line = UIView.separator
        textField.addSubview(line)
        line.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        line.topAnchor.constraint(equalTo: textField.lastBaselineAnchor, constant: 6).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale).isActive = true
        return textField
    }()
}

class CustomTextfield: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 22))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 22))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 22))
    }
}
