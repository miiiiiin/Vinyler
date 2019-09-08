//
//  UIView+Exntension.swift
//  Vinyler
//
//  Created by 민송경 on 15/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    convenience init(forAutoLayout: ()) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    static var background: UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }

    func pinToSuperview(withInsets insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("Can't set constraints to a view which has no superview")
        }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom).isActive = true
    }

    func pin(to view: UIView, withInsets insets: UIEdgeInsets = .zero) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }

    func centerInSuperview() {
        guard let superview = superview else {
            fatalError("Can't set constraints to a view which has no superview")
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
}
