//
//  ReviewSummaryView.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/10/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ReviewView: UIView {
    
    var contentView = UIView.background
    var ratingView: CosmosView!
    let titleLabel = UILabel.subheader
    let separator = UIView.separator
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    private func setUpLayout() {
        ratingView = CosmosView()
        addSubview(contentView)
        [ratingView, titleLabel, separator].forEach(contentView.addSubview)
        
        ratingView.rating = 0
        ratingView.settings.updateOnTouch = true
        ratingView.settings.fillMode = .full
        ratingView.settings.starSize = 30
        ratingView.settings.starMargin = 5
        ratingView.settings.emptyBorderColor = .clear
        ratingView.settings.filledColor = .systemYellow
        ratingView.settings.emptyColor = .veryLightPink
        
        titleLabel.text = .reviewGuide
        separator.backgroundColor = .veryLightPink
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(38)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(14)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(17)
        }
        
        separator.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-1)
            make.leading.equalToSuperview().offset(33)
            make.trailing.equalToSuperview().offset(-33)
        }
    }
}
