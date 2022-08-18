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
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .tertiarySystemBackground
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = .darkGray
        }
        
        title = .search
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = .black
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        
        
        
    
    }
    
    func setUpUI() {
        [collectionView].forEach(self.view.addSubview(_:))
        
        collectionView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
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
