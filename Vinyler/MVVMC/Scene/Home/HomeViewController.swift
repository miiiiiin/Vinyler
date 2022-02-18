//
//  HomeViewController.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, ViewModelBindableType {
   
    // MARK: - ViewModel
    
    var viewModel: HomeViewModelType!
    
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Bind
    
    func bindViewModel() {
        
    }
}
