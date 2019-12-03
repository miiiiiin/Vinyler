//
//  DisclosureButton.swift
//  Vinyler
//
//  Created by Min on 2019/12/04.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DisclosureButton: UIControl {
    
    let titleLbl = UILabel.body
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let disclosureImageView = UIImageView(forAutoLayout: ())
        let bottomSeparator = UIView.separator
        
        [titleLbl, disclosureImageView, bottomSeparator].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            disclosureImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLbl.trailingAnchor, constant: 44),
            disclosureImageView.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor),
            disclosureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            bottomSeparator.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 21),
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        disclosureImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        disclosureImageView.image = .disclosure
        disclosureImageView.tintColor = .dark
    }
}

extension Reactive where Base: DisclosureButton {
    var tap: ControlEvent<Void> {
        return base.rx.controlEvent(.touchUpInside)
    }
}
