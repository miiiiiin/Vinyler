//
//  MenuCell.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import UIKit
import SnapKit

class MenuCell: UITableViewCell {
    
    let imageView = UIImageView.menu
    let titleLabel = UILabel.body
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        titleLabel.textColor = style.Colors.tint
        [imageView, titleLabel].forEach(addSubview)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.topAnchor).offset(33)
            make.leading.equalToSuperview().offset(33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        backgroundColor = .clear
        titleLabel.numberOfLines = 1
    }
    
}
