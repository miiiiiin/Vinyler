//
//  HomeViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/10.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

//class HomeViewController: UIViewController {
//
//    private let scanLabel = UILabel.header
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        UIFont.familyNames.forEach { item in
//            print("font name: \(item)")
//        }
//    }
//
//    override func loadView() {
//        let root = UIView.background
//        root.backgroundColor = .black
//
//        [scanLabel].forEach(root.addSubview(_:))
//        scanLabel.set(headerText: "Scan The Barcode")
//
//        let scanCenter = scanLabel.centerYAnchor.constraint(equalTo: root.centerYAnchor, constant: -50)
//        scanCenter.priority = .defaultLow
//
//        NSLayoutConstraint.activate([
//
//            scanLabel.centerYAnchor.constraint(equalTo: root.centerYAnchor),
//            scanLabel.centerXAnchor.constraint(equalTo: root.centerXAnchor),
//
//        ])
//
//        self.view = root
//    }
//}
