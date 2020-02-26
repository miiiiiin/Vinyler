//
//  CustomActionSheetCell.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class CustomActionSheetCell: UITableViewCell {
    
    let label = UILabel.header
    let iconImageView = UIImageView(forAutoLayout: ())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func update(option: ActionSheetOption) {
        label.text = option.title
        label.textColor = style.Colors.tint
        
        if #available(iOS 13.0, *) {
            option.iconImage?.withTintColor(style.Colors.tint)
        }
        iconImageView.image = option.iconImage
    }
    
    private func setUp() {
        
        [label, iconImageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            label.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 28),
            iconImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .clear
        iconImageView.tintColor = style.Colors.tint
        selectionStyle = .blue
    }
    
}
