//
//  LoadingViewController.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LoadingViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: LoadingViewModelType!
    
    let activityIndicatorView = ActivityIndicatorView()
    var activityIndicatorCenterY = NSLayoutConstraint()
    let errorTitleLabel = UILabel.block
    let errorMessageLabel = UILabel.header
    let cancelButton = UIButton.cancel
    private let disposeBag = DisposeBag()
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        
        self.setTextColors(labels: [errorTitleLabel, errorMessageLabel])
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        
        errorMessageLabel.addGestureRecognizer(tapGestureRecognizer)
        errorMessageLabel.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.cancelButton.alpha = 1
            self?.activityIndicatorView.alpha = 0
            self?.errorTitleLabel.isHidden = false
            self?.errorMessageLabel.isHidden = false
        }
        
        _ = cancelButton.rx.tap.flatMap { _ -> Observable<Void> in Observable.error(error)}
        
        _ = tapGestureRecognizer.rx.event.map { $0.didTap(oneOf: [.retry]) }.flatMap { _ in Observable.just(()) }
            .do(onNext: {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.cancelButton.alpha = 0
                    self?.activityIndicatorView.alpha = 1
                    self?.errorTitleLabel.isHidden = true
                    self?.errorMessageLabel.isHidden = true
                }
            }).delay(.seconds(Int(0.5)), scheduler: MainScheduler.instance)
        return Observable.error(error)//.merge(close, retry)
    }
    
    init(artistResourceUrl: String) {
        super.init(nibName: nil, bundle: nil)
        
        let discogs = DiscogsAPI()
        let fetchRelease = discogs.fetchArtist(path: artistResourceUrl)
        
        handleObservable(observable: fetchRelease).flatMap { [weak self] artist -> ControlEvent<Void> in
            
            let artistVC = ArtistViewController(artist: artist)
            self?.navigationController?.pushViewController(artistVC, animated: true)
            
            return artistVC.rx.viewDidAppear
            
        }.subscribe(onNext: { [weak self] in
            guard let `self` = self, let index = self.navigationController?.viewControllers.index(of: self) else  { return }
            
            self.navigationController?.viewControllers.remove(at: index)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.image = #imageLiteral(resourceName: "loader2")
        activityIndicatorView.tintColor = style.Colors.tint
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
        self.modalPresentationStyle = .fullScreen
        
        stackView.centerXAnchor.constraint(equalTo: root.centerXAnchor).isActive = true
        activityIndicatorCenterY = stackView.centerYAnchor.constraint(equalTo: root.centerYAnchor)
        activityIndicatorCenterY.isActive = true
        stackView.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 44).isActive = true
        activityAndClose.heightAnchor.constraint(equalToConstant: 99).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: activityAndClose.bottomAnchor).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: activityAndClose.centerXAnchor).isActive = true
        activityIndicatorView.pin(to: cancelButton)
        
        self.view = root
        
        cancelButton.alpha = 0
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.errorEvent
            .subscribe(onNext: { [weak self] error in
                self?.showNetworkError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
}
