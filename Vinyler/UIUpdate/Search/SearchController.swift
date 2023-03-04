//
//  SearchController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/08/30.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias ResultsSection = Section<Results>

class SearchController: UICollectionViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = .search
        
        collectionView.backgroundColor = .white
        
        collectionView.delegate = nil
        collectionView.dataSource = nil
        
        let searchController = UISearchController(searchResultsController: nil)
//        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .dark
        definesPresentationContext = true
        navigationItem.searchController = searchController
//        navigationItem.backBarButtonItem = .empty
  
        let discogs = DiscogsAPI()
//        searchController.searchBar.rx.text.orEmpty
//            .distinctUntilChanged()
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .asDriver(onErrorJustReturn: "")
//            .filter { !$0.isEmpty }
//            .flatMapLatest { query in
//                return discogs.search(query: query).startWith([]).asDriver(onErrorJustReturn: [])
//            }
//            .drive(rx.sections)
//            .disposed(by: disposeBag)
        
        
        collectionView.rx.modelSelected(Results.self)
            .subscribe(onNext: { [weak self] result in
//                let albumViewController = AlbumViewController()
//                self?.navigationController?.pushViewController(albumViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.willBeginDragging.subscribe(onNext: {
            searchController.resignFirstResponder()
        })
        .disposed(by: disposeBag)
    }
}

extension Reactive where Base: SearchController {
    
}
