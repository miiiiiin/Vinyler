//
//  SearchResultCell.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/08/30.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchResultsUpdateable {
    func update(with searchResult: Result)
}

class SearchResultCell: UICollectionViewCell, SearchResultsUpdateable {
    
    private let albumImageView = UIImageView(forAutoLayout: ())
    private let releaseTitleLabel = UILabel.body
    private let infoLabel = UILabel.metadata
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
    }
    
    func update(with searchResult: Result) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
