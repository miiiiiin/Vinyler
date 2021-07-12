//
//  SettingsHeaderView.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/13.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class SettingsHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        textLabel?.font = UIFont.mediumFont(with: 15)
        textLabel?.textColor = .blue
    }
}
