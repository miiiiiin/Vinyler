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

class MainViewController: UIViewController {
    
    let moreButton = UIButton.more
    let scanLabel = UILabel.header
    let searchButton = UIButton.search
    let animationView = AnimationView.animationView
    let vinylAnimationView = AnimationView.vinylAnimationView
    
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
        vinylAnimationView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                
                let scanVC = ScanViewController()
                self.navigationController?.pushViewController(scanVC, animated: true)
            })
            .disposed(by: bag)
        
        searchButton.rx.tap.subscribe(onNext: { [weak self] in
            let searchViewController = SearchViewController()
            self?.navigationController?.pushViewController(searchViewController, animated: true)
        }).disposed(by: bag)
        
        moreButton.rx.tap.subscribe(onNext: { [weak self] in
//            self?.navigationController?.pushViewController(AppInfoViewController(), animated: true)
            
            self?.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }).disposed(by: bag)
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
        
        moreButton.tintColor = .white
        
        [moreButton, scanLabel, searchButton, animationView, vinylAnimationView].forEach(root.addSubview)
        scanLabel.set(headerText: .scan)
        
        let scanCenter = scanLabel.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -50)
        scanCenter.priority = .defaultLow
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 33),
            moreButton.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 44),
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
}
