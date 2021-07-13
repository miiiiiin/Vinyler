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
        
        
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            releaseTitleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: .margin),
        ])
        
        
        
    }
}
