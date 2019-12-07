//
//  SearchViewController.swift
//  Vinyler
//
//  Created by Min on 2019/12/07.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SearchViewController: UITableViewController {

    private let backBtn = UIButton.back
    private let inputField = UITextField.standard
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        
    }
}
