//
//  DynamicTableView.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class DynamicTableView: UITableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !__CGSizeEqualToSize(bounds.size, intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
