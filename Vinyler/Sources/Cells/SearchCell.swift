//
//  SearchCell.swift
//  Vinyler
//
//  Created by Min on 2019/12/08.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCell: UICollectionViewCell {
    
    private let albumImageView = UIImageView(forAutoLayout: ())
    private let releaseTitleLabel = UILabel.body
    private let infoLabel = UILabel.metadata
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        
        [albumImageView, releaseTitleLabel, infoLabel].forEach(contentView.addSubview(_:))
        
        albumImageView.pinToSuperview(anchors: [.left, .top, .bottom])
        
        releaseTitleLabel.pinToSuperview(anchors: [.top, .right], withInsets: UIEdgeInsets(top: .margin, left: 0, bottom: 0, right: -16))
        
        infoLabel.pinToSuperview(anchors: [.bottom, .right], withInsets: UIEdgeInsets(top: 0, left: 0, bottom: -6, right: -16))
        
        
        infoLabel.setContentHuggingPriority(.required, for: .vertical)
        
        let width = UIScreen.main.bounds.width - 2 * 2 * .margin

        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            releaseTitleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: .margin),
            
            infoLabel.topAnchor.constraint(equalTo: releaseTitleLabel.bottomAnchor, constant: 5),
            infoLabel.leadingAnchor.constraint(equalTo: releaseTitleLabel.leadingAnchor),
            
        ])
        
        
//        infoLabel.leadingAnchor.constraint(equalTo: releaseTitleLabel.leadingAnchor).isActive = true
//        infoLabel.setContentHuggingPriority(.required, for: .vertical)
//        let width = UIScreen.main.bounds.width - 2 * 2 * .margin
//        contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
//        contentView.heightAnchor.constraint(equalToConstant: 110).isActive = true
//
//        releaseTitleLabel.numberOfLines = 3
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 11
//        contentView.clipsToBounds = true
//        setShadow()
        
    }
}
