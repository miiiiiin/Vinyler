//
//  ReviewCell.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/10/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ReviewCell: UITableViewCell {
    let imageView = UIImageView(forAutoLayout: ())
    let stackView = UIStackView(forAutoLayout: ())
    let nicknameLabel = UILabel.subheader
    let reviewLabel = UILabel.body
    var ratingView: CosmosView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }
    
    private func setUp() {
        ratingView = CosmosView()
        imageView.image = .reviewPlaceholder
        [imageView, stackView].forEach(addSubview)
        [nicknameLabel, ratingView, reviewLabel].forEach(stackView.addArrangedSubview)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 6
        
        self.setTextColors(labels: [nicknameLabel, reviewLabel])
    }
}
