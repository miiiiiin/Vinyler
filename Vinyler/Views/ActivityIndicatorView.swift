//
//  ActivityIndicatorView.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIImageView {
    
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        rotate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        rotate()
    }
    
    private func rotate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { [weak self] in
            guard let `self` = self else { return }
            self.transform = self.transform.rotated(by: .pi)
        }) { [weak self] _ in
            self?.rotate()
        }
    }
    
}
