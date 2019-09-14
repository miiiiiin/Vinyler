//
//  CustomActionSheetHeader.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class CustomActionSheetHeader: UIView {
    
    let closeButton = UIButton.close
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            
            closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            closeButton.topAnchor.constraint(equalTo: topAnchor)
            
        ])
    }
}
