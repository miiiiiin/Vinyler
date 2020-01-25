//
//  AppInfoViewController.swift
//  Vinyler
//
//  Created by Min on 2020/01/25.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class AppInfoViewController: UIViewController {
    
    let backBtn = UIButton.back
    let greetingLbl = UILabel.block
    let introduceBlock = CustomTextView(forAutoLayout: ())
    let openSourceBlock = CustomTextView(forAutoLayout: ())
    private let dispoeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        
    }
}
