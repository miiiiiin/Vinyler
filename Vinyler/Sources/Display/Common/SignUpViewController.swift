//
//  SignUpViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, ViewModelBindableType {
 
    
    // MARK: - ViewModel
    
    var viewModel: SignUpViewModelType!
    
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
    }
    
    private func setUp() {
        
    }
    
    func bindViewModel() {
        
    }
    
    
}
