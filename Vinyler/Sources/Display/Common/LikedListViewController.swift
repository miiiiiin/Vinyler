//
//  LikedListViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class LikedListViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: LikedListViewModelType!
    
    let backButton = UIButton.back
    let tableView = UITableView(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        
    }
}
