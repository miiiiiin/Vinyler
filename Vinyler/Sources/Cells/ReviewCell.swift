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
    let imgView = UIImageView(forAutoLayout: ())
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
    
    func update(with result: Review) {
        ratingView.rating = Double(result.rating)
        reviewLabel.text = result.content
        nicknameLabel.text = "User #\(result.id)"
    }
    
    private func setUp() {
        ratingView = CosmosView()
        imgView.image = #imageLiteral(resourceName: "review_placeholder")
        [imgView, stackView].forEach(addSubview)
        [nicknameLabel, ratingView, reviewLabel].forEach(stackView.addArrangedSubview)
        
        imgView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        
        self.setTextColors(labels: [nicknameLabel, reviewLabel])
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(18.5)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(55)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(15.5)
            make.leading.equalTo(imgView.snp.trailing).offset(24)
            make.trailing.equalToSuperview()
        }
    }
}
