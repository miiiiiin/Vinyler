//
//  MainViewController.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Lottie
import RxGesture

class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: MainViewModelType!
    
    var myPageButton = UIButton.more
    let scanLabel = UILabel.header
    var searchButton = UIButton.search
    let animationView = LottieAnimationView.animationView
    let vinylAnimationView = LottieAnimationView.vinylAnimationView
    
    private let navigationControllerDelegate = NavigationControllerDelegate()
    
    private let bag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showAnim()
    }
    
    private func setUp() {
        
    }
    
    private func showAnim() {
        animationView.loopMode = .loop
        animationView.play()
        vinylAnimationView.loopMode = .loop
        vinylAnimationView.play()
    }
    
    override func loadView() {
        let root = UIView.background
        root.backgroundColor = .coldDarkBlue
        
        myPageButton.tintColor = .white
        
        [myPageButton, scanLabel, searchButton, animationView, vinylAnimationView].forEach(root.addSubview)
        
        scanLabel.textAlignment = .center
        scanLabel.set(headerText: .scan)
        
        let scanCenter = scanLabel.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -50)
        scanCenter.priority = .defaultLow
        NSLayoutConstraint.activate([
            myPageButton.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 33),
            myPageButton.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 44),
            animationView.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -33),
            animationView.centerXAnchor.constraint(equalTo: root.centerXAnchor),
            vinylAnimationView.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -33),
            vinylAnimationView.centerXAnchor.constraint(equalTo: root.centerXAnchor),
            scanLabel.topAnchor.constraint(greaterThanOrEqualTo: vinylAnimationView.bottomAnchor, constant: 90),
            scanLabel.centerXAnchor.constraint(equalTo: root.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: scanLabel.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: root.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 300),
            searchButton.bottomAnchor.constraint(equalTo: root.bottomAnchor, constant: -40)
        ])
        
        self.view = root
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        vinylAnimationView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                input.scanAction.execute(())
            })
            .disposed(by: bag)
        
        myPageButton.rx.action = input.myPageAction
        
        searchButton.rx.action = input.searchAction
    }
}
