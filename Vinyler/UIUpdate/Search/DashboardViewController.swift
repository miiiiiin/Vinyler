//
//  DashboardViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/08/19.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import PanModal

//typealias SearchResultsSection = Section<Result>

class DashboardViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        if #available(iOS 13.0, *) {
            cv.backgroundColor = .systemGroupedBackground
        } else {
            // Fallback on earlier versions
        }
        return cv
    }()
    
    let historyLabel = UILabel.header
    let searchButton = UIButton.search
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.mainColor
        
        title = .search
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = .white
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        debugPrint("check navigation item: \(navigationItem.searchController)")
        
        self.navigationController?.navigationBar.isHidden = false
        self.setUpUI()
        
        searchButton.rx.tap
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let searchVC = SearchController()
                self?.navigationController?.present(searchVC, animated: true)
            })
        
    
    }
    
    func setUpUI() {
        
        historyLabel.text = .history
        historyLabel.textColor = .cream
        
        [searchButton, historyLabel].forEach(self.view.addSubview(_:))
        
        historyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.leading.equalToSuperview().offset(44)
            make.height.width.equalTo(28)
        }
//        [collectionView].forEach(self.view.addSubview(_:))

//        collectionView.snp.makeConstraints { make in
//
//            make.top.equalToSuperview().offset(40)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
    }
}

extension DashboardViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}
