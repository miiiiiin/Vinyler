//
//  LikeCell.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class LikeCell: UITableViewCell {
    
    let albumImageView = UIImageView(forAutoLayout: ())
    let artistLabel = UILabel.header
    let titleLabel = UILabel.subheader
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        [albumImageView, artistLabel, titleLabel].forEach(addSubview)
        
        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(33)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(15)
            make.top.equalTo(albumImageView.snp.top)
            make.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(artistLabel.snp.leading)
            make.top.equalTo(artistLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview()
        }
    }
}
