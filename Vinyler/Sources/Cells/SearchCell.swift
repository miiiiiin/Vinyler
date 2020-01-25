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

class SearchCell: UITableViewCell {
    
    private let albumImageView = UIImageView(forAutoLayout: ())
    private let titleLbl = UILabel.subheader
    private let releaseDetailsLbl = UILabel.body
    private let formatsLabel = UILabel.bodyLight
    private var disposeBag = DisposeBag()
    
    func update(with searchResult: Result) {
        disposeBag = DisposeBag()
//        albumImageView.image =
        
        let imageDriver: Driver<UIImage?>
        if let imgUrl = URL(string: searchResult.thumb) {
            
            let request = URLRequest(url: imgUrl)
            imageDriver = URLSession.shared.rx.data(request: request).map(UIImage.init).asDriver(onErrorJustReturn: nil)
        } else {
            imageDriver = Driver.just(nil)
        }
        
        imageDriver.filter { $0 != nil }.drive(albumImageView.rx.image).disposed(by: disposeBag)
        titleLbl.text = searchResult.title
        
        var releaseDetailStr = searchResult.country
        if let year = searchResult.year {
            releaseDetailStr += ", " + year
        }
        
        releaseDetailsLbl.text = releaseDetailStr
        formatsLabel.text = searchResult.format.joined(separator: ", ")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        [albumImageView, titleLbl, releaseDetailsLbl, formatsLabel].forEach(addSubview)
               albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44).isActive = true
               albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 33).isActive = true
               albumImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
               albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor).isActive = true
               titleLbl.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 11).isActive = true
               titleLbl.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 22).isActive = true
               titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
               releaseDetailsLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 11).isActive = true
               releaseDetailsLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor).isActive = true
               releaseDetailsLbl.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor).isActive = true
               formatsLabel.topAnchor.constraint(equalTo: releaseDetailsLbl.bottomAnchor, constant: 11).isActive = true
               formatsLabel.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor).isActive = true
               formatsLabel.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor).isActive = true
               
               titleLbl.numberOfLines = 2
               albumImageView.contentMode = .scaleAspectFill
               albumImageView.clipsToBounds = true
    }
    
    
    override func prepareForReuse() {
           albumImageView.image = .placeholder
    }
    
}
