//
//  ScanViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/03/10.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class ScanViewController: BaseViewController, viewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: ScanViewModelType!

    // MARK: - UI Properties
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
    }
}
