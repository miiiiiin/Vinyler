//
//  IntroductionViewcontroller.swift
//  Vinyler
//
//  Created by Running Raccoon on 2020/01/10.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IntroductionViewcontroller: UIViewController {
    
    let backBtn = UIButton.back
    let headerTitleLbl = UILabel.block
//    let openSourceSection = 
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        let root = UIScrollView(frame: UIScreen.main.bounds)
        root.backgroundColor = .white
        let contentView = UIView(forAutoLayout: ())
        let stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        stackView.spacing = 33
        root.addSubview(contentView)
        
        contentView.pinToSuperview()
        contentView.widthAnchor.constraint(equalTo: root.widthAnchor).isActive = true
    }
}
