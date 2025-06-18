//
//  ReviewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/18/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ReviewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: ReviewViewModelType!
    
    private let closeButton = UIButton.close
    private let titleLabel = UILabel.header
    private let artistLabel = UILabel.subheader
    private var albumImageView = UIImageView(forAutoLayout: ())
    private var ratingView: CosmosView!
    private let reviewTextView = UITextView.writeBody
    private let doneButton = UIButton.done
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    func setUpLayout() {
        let root = UIScrollView(frame: UIScreen.main.bounds)
        let contentView = UIView(forAutoLayout: ())
        [contentView, doneButton].forEach(root.addSubview)
        contentView.pinToSuperview()
        self.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            //            root.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        } else {
            //            root.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
        
        [closeButton, titleLabel, artistLabel, albumImageView, ratingView, reviewTextView].forEach(contentView.addSubview)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(33)
            make.leading.equalToSuperview().offset(33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(33)
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.trailing.equalToSuperview()
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.trailing.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(44)
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-44)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(33)
            make.width.equalTo(210)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(38)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(33)
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        doneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        
    }
}
