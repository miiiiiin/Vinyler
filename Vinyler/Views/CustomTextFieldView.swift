//
//  CustomTextFieldView.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/16/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class CustomTextFieldView: UIView {
    
    let titleLabel = UILabel.subheader
    
    lazy var textField: UITextField = {
        let tf = UITextField(forAutoLayout: ())
        tf.placeholder = .search
        tf.sizeToFit()
        tf.clearButtonMode = .whileEditing
        tf.borderStyle = .none
        tf.textColor = style.Colors.tint
        tf.font = UIFont.body
        tf.clearButtonMode = .whileEditing
        tf.text = nil
        tf.contentVerticalAlignment = .center
        tf.clearsOnInsertion = false
        tf.clearsOnBeginEditing = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        let line = UIView.separator
        tf.addSubview(line)
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    public func setLabel(str: String, text: String) {
        titleLabel.set(headerText: str)
        textField.placeholder = text
    }
    
    public func setLabelColor(label: UIColor, text: UIColor) {
        titleLabel.textColor = label
        textField.textColor = text
    }
    
    private func setUpLayout() {
        textField.isUserInteractionEnabled = true
        
        titleLabel.textColor = style.Colors.tint
        textField.textColor = style.Colors.tint
        
        [titleLabel, textField].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
    }
}
