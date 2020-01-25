//
//  MainViewController.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class MainViewController: UIViewController {

    let moreButton = UIButton.more
    let greetingLabel = UILabel.block
    let scanLabel = UILabel.header
    let searchButton = UIButton.search
    let cameraButton = UIButton.camera
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

    private func setUp() {
        cameraButton.rx.tap.subscribe(onNext: { [weak self] in
            let scanVC = ScanViewController()
            self?.navigationController?.pushViewController(scanVC, animated: true)
        }).disposed(by: bag)
        
        
        searchButton.rx.tap.subscribe(onNext: { [weak self] in
             let searchViewController = SearchViewController()
                              self?.navigationController?.pushViewController(searchViewController, animated: true)
            }).disposed(by: bag)
        
 

        moreButton.rx.tap.subscribe(onNext: { [weak self] in        self?.navigationController?.pushViewController(AppInfoViewController(), animated: true)
        }).disposed(by: bag)
    }

    override func loadView() {
        let root = UIView.background
        root.backgroundColor = UIColor(red: 255 / 255, green: 208 / 255, blue: 53 / 255, alpha: 1.0)

        [moreButton, greetingLabel, scanLabel, searchButton, cameraButton].forEach(root.addSubview)
        greetingLabel.text = String.hello
        scanLabel.set(headerText: .scan)

        let scanCenter = scanLabel.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -50)
        scanCenter.priority = .defaultLow
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 33),
            moreButton.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 44),
            cameraButton.centerYAnchor.constraint(equalTo: root.centerYAnchor),
            cameraButton.centerXAnchor.constraint(equalTo: root.centerXAnchor),
        greetingLabel.topAnchor.constraint(greaterThanOrEqualTo: cameraButton.bottomAnchor, constant: 90),
            greetingLabel.leadingAnchor.constraint(equalTo: scanLabel.leadingAnchor),
            scanLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 22),
            scanLabel.centerXAnchor.constraint(equalTo: root.centerXAnchor),
            scanCenter,
            searchButton.topAnchor.constraint(equalTo: scanLabel.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: root.centerXAnchor)
        ])
        
        self.view = root
    }
}
