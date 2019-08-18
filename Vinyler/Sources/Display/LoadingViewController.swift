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
//    let errorMessageLabel = UITextView.header
    let cancelButton = UIButton.cancel
    private let bag = DisposeBag()
    
    
    init(code: String) {
        super.init(nibName: nil, bundle: nil)
        
        let discogs = DiscogsAPI()
        
//        let fetchRelease = discogs.search(query: code)
//            .flatMap { searchResults -> Observable<Release> in
//                guard let firstUrl = searchResults.first?.resourceUrl else {
//                    return Observable.error(RequestError.noResults)
//                }
//                return discogs.fetchRelease(for: firstUrl)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
