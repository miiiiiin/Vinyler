//
//  LikeCell.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LikeCell: UITableViewCell {
    
    let albumImageView = UIImageView(forAutoLayout: ())
    let artistLabel = UILabel.header
    let titleLabel = UILabel.subheader
    let dateLabel = UILabel.subheader
    private var disposeBag = DisposeBag()
    //    let moreButton = UIButton.more
    
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
    
    func update(with result: VinylerRelease) {
        var imageDriver: Driver<UIImage?>
        if let image = result.images.first, let imgUrl = URL(string: image.uri)  {
            
            let request = URLRequest(url: imgUrl)
            imageDriver = URLSession.shared.rx.data(request: request).map(UIImage.init).asDriver(onErrorJustReturn: nil)
            
        } else {
            imageDriver = Driver.just(nil)
        }
        
        imageDriver.filter { $0 != nil }.drive(albumImageView.rx.image).disposed(by: disposeBag)
        
        titleLabel.text = result.title
        artistLabel.text = result.artistsSort
        dateLabel.text = result.releasedFormatted
    }
    
    private func setUp() {
        self.setTextColors(labels: [titleLabel, artistLabel, dateLabel])
        
        [albumImageView, artistLabel, titleLabel, dateLabel].forEach(addSubview)
        albumImageView.image = .placeholder
        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(80)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(15)
            make.top.equalTo(albumImageView.snp.top)
            make.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(artistLabel.snp.leading)
            make.top.equalTo(artistLabel.snp.bottom).offset(6)
            make.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.trailing.equalToSuperview()
        }
    }
    override func prepareForReuse() {
        albumImageView.image = .placeholder
    }
}
