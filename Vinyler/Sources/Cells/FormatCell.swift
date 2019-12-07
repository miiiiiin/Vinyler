//
//  FormatCell.swift
//  Vinyler
//
//  Created by Min on 2019/12/04.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class FormatCell: UICollectionViewCell {
    
    let titleLbl = UILabel.format
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setUp()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setUp()
      }
    
    private func setUp() {
        self.addSubview(titleLbl)
        heightAnchor.constraint(equalToConstant: 29).isActive = true
               titleLbl.pinToSuperview(withInsets: UIEdgeInsets(top: 0, left: 11, bottom: 0, right: -11))
                backgroundColor = .coral
               layer.cornerRadius = 13
    }
}
