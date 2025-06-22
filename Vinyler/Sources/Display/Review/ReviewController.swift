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
import RxSwift

class ReviewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: ReviewViewModelType!
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
            label.textAlignment = .center
        }
    }
    
    private func setupKeyboardHandling(scrollView: UIScrollView) {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .subscribe(onNext: { [weak self] keyboardFrame in
                guard let self = self else { return }
                let keyboardHeight = keyboardFrame.height
                scrollView.contentInset.bottom = keyboardHeight + 100
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] _ in
                scrollView.contentInset.bottom = 0
            })
            .disposed(by: disposeBag)
    }
    
    func setUpLayout() {
        //        let root = UIScrollView(frame: UIScreen.main.bounds)
        let root = UIView()
        let contentView = UIView(forAutoLayout: ())
        root.addSubview(scrollView)
        scrollView.addSubview(contentView)
        root.addSubview(doneButton)
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        self.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            root.backgroundColor = .systemBackground
        } else {
            root.backgroundColor = .white
        }
        
        doneButton.setTitle(.done, for: .normal)
        doneButton.backgroundColor = .coldDarkBlue
        
        ratingView = CosmosView()
        setupKeyboardHandling(scrollView: scrollView)
        
        let containerView = UIView()
        [containerView, closeButton].forEach(contentView.addSubview)
        
        [titleLabel, artistLabel, albumImageView, ratingView, reviewTextView].forEach(containerView.addSubview)
        
        self.setTextColors(labels: [titleLabel, artistLabel])
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
        
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(33)
            make.leading.trailing.equalTo(contentView)
            make.leading.trailing.equalTo(contentView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(33)
            make.leading.equalToSuperview().offset(33)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(33)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.trailing.equalToSuperview()
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.trailing.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(44)
            //            make.leading.equalToSuperview().offset(44)
            //            make.trailing.equalToSuperview().offset(-44)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(albumImageView.snp.width)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(33)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(33)
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        //        doneButton.snp.makeConstraints { make in
        //            make.leading.equalTo(reviewTextView.snp.leading)
        //            make.trailing.equalTo(reviewTextView.snp.trailing)
        //            make.height.equalTo(50)
        //            make.centerX.equalToSuperview()
        //            make.bottom.equalTo(root.safeAreaLayoutGuide.snp.bottom).offset(-24)
        //        }
        //
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(reviewTextView.snp.leading)
            make.trailing.equalTo(reviewTextView.snp.trailing)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(root.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        //
        //        doneButton.snp.makeConstraints { make in
        //            make.leading.equalTo(reviewTextView.snp.leading)
        //            make.trailing.equalTo(reviewTextView.snp.trailing)
        //            make.height.equalTo(50)
        //            make.centerX.equalToSuperview()
        //            if #available(iOS 15.0, *) {
        //                make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
        //            } else {
        //                make.bottom.equalToSuperview().inset(30)
        //            }
        //        }
        
        
        self.view = root
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.rating
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.ratingView.rating = Double(value)
            })
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .observe(on: MainScheduler.instance)
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .observe(on: MainScheduler.instance)
            .map { $0.artistsSort }
            .bind(to: artistLabel.rx.text)
            .disposed(by: disposeBag)
        
        ratingView.didFinishTouchingCosmos = { value in
            input.ratingValue.accept(Int(value))
        }
        
        output.rating
            .bind(to: input.ratingValue)
            .disposed(by: disposeBag)
        
        output.albumImage
            .drive(albumImageView.rx.image)
            .disposed(by: disposeBag)
        
        reviewTextView.rx.textChanged
            .observe(on: MainScheduler.instance)
            .bind(to: input.reviewInput)
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .observe(on: MainScheduler.instance)
            .withLatestFrom(output.releaseInfo)
            .map { $0.id }
            .bind(to: input.reviewAction.inputs)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind(to: input.dismissAction.inputs)
            .disposed(by: disposeBag)
        
    }
}

extension Reactive where Base: UITextView {
    var textChanged: Observable<String> {
        self.didChange
            .map { [weak base] in base?.text ?? "" }
    }
}
