//
//  LoadingViewController.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingViewController: UIViewController {
    
    let activityIndicatorView = ActivityIndicatorView()
    var activityIndicatorCenterY = NSLayoutConstraint()
    let errorTitleLabel = UILabel.block
    let errorMessageLabel = UILabel.header
    let cancelButton = UIButton.cancel
    private let disposeBag = DisposeBag()
    
    
    init(barcode: String) {
        super.init(nibName: nil, bundle: nil)
        
        let discogs = DiscogsAPI()
        
        let fetchRelease = discogs.search(query: barcode)
            .flatMap { searchResults -> Observable<Release> in
                guard let firstUrl = searchResults.first?.resourceUrl else {
                    return Observable.error(RequestError.noResults)
                }
                return discogs.fetchRelease(firstUrl)
        }
        
        handleObservable(observable: fetchRelease).subscribe(onNext: { [weak self] release in
            let albumVC = AlbumViewController(release: release)
            self?.navigationController?.popViewController(animated: true)
            self?.navigationController?.pushViewController(albumVC, animated: true)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func handleObservable<T>(observable: Observable<T>) -> Observable<T> {
        
        return rx.viewDidLoad.flatMap { observable.timeout(3, scheduler: MainScheduler.instance)
            }.catchError { error in
                guard let rxError = error as? RxError else {
                    return Observable.error(error)
                }
                switch rxError {
                case .timeout:
                    return Observable.error(error)
                default:
                    return Observable.error(error)
                }
            }.observeOn(MainScheduler.instance)
            .retryWhen(errorHandler)
    }
    
    private func errorHandler(errorObservable: Observable<Error>) -> Observable<Void> {
        return errorObservable.flatMap(showNetworkError)
    }
    
    private func showNetworkError(error: Error) -> Observable<Void> {
        
        var errorTitle: String
        var errorMessage: String
        
        if let networkError = error as? RequestError {
            switch networkError {
            case .invalidUrl:
                errorTitle = .genericErrorTitle
                errorMessage = .genericErrorMessage
            case .noResults:
                errorTitle = .noResultsErrorTitle
                errorMessage = .noResultsErrorMessage
            case .unavailable:
                errorTitle = .connectionErrorTitle
                errorMessage = String(format: .connectionErrorMessage, String.retry)
            }
        } else {
            errorTitle = .genericErrorTitle
            errorMessage = .genericErrorMessage
        }
        
        errorTitleLabel.text = errorTitle
        errorMessageLabel.set(headerText: errorMessage)
        
//        let tapGestureRecognizer = UITapGestureRecognizer()
//
//        errorMessageLabel.addGestureRecognizer(tapGestureRecognizer)
//        errorMessageLabel.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.cancelButton.alpha = 1
            self?.activityIndicatorView.alpha = 0
            self?.errorTitleLabel.isHidden = false
            self?.errorMessageLabel.isHidden = false
        }
        
//        let close = cancelButton.rx.tap.flatMap { _ -> Observable<Void> in Observable.error(error)}
        
//        let retry = tapGestureRecognizer.rx.event.map { $0.didTap(oneOf: [.retry]) }.flatMap { _ in Observable.just(()) }
//            .do(onNext: {
//                UIView.animate(withDuration: 0.3) { [weak self] in
//                    self?.cancelButton.alpha = 0
//                    self?.activityIndicatorView.alpha = 1
//                    self?.errorTitleLabel.isHidden = true
//                    self?.errorMessageLabel.isHidden = true
//                }
//            }).delay(0.5, scheduler: MainScheduler.instance)
        return Observable.error(error)//.merge(close, retry)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.image = #imageLiteral(resourceName: "loader2")
        activityIndicatorView.tintColor = .gray
        cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func loadView() {
        let root = UIView.background
        let stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        stackView.spacing = 30
        let activityAndClose = UIView(forAutoLayout: ())
        
        [activityIndicatorView, cancelButton].forEach(activityAndClose.addSubview)
        [errorTitleLabel, errorMessageLabel, activityAndClose].forEach(stackView.addArrangedSubview)
        
        errorTitleLabel.isHidden = true
        errorMessageLabel.isHidden = true
        
        root.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: root.centerXAnchor).isActive = true
        activityIndicatorCenterY = stackView.centerYAnchor.constraint(equalTo: root.centerYAnchor)
        activityIndicatorCenterY.isActive = true
        stackView.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 44).isActive = true
        activityAndClose.heightAnchor.constraint(equalToConstant: 99).isActive = true
        cancelButton.topAnchor.constraint(equalTo: activityAndClose.topAnchor, constant: 22).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: activityAndClose.bottomAnchor).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: activityAndClose.centerXAnchor).isActive = true
        activityIndicatorView.pin(to: cancelButton)
        
        self.view = root
        
        cancelButton.alpha = 0
    }
}
