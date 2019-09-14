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
        iconImageView.image = option.iconImage        
    }
    
    private func setUp() {
        
        [label, iconImageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([            iconImageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 28),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            iconImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .clear
        iconImageView.tintColor = .dark
        selectionStyle = .blue
    }
    
}
