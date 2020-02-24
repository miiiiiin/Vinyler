//
//  TrackCell.swift
//  Vinyler
//
//  Created by Min on 15/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TrackCell: UITableViewCell {
    
    let positionLabel = UILabel.position
    let titleLabel = UILabel.body
    let durationLabel = UILabel.bodyLight
    
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
        
        self.setTextColors(labels: [positionLabel, titleLabel, durationLabel])
        
        [positionLabel, titleLabel, durationLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
        
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44),
            positionLabel.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 11),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            durationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 22),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            durationLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
            
        ])
        
        durationLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        backgroundColor = .clear
        titleLabel.numberOfLines = 1
        durationLabel.numberOfLines = 1
    }
}
