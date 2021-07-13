//
//  UIView+Layout.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/13.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import UIKit

extension UIView {
    
    
 
//    func pinToSuperview(anchors: UIRectEdge = .all, withInsets insets: UIEdgeInsets = .zero) {
//        guard let superview = superview else {
//            fatalError("Can't set constraints to a view which has no superview")
//        }
//        pin(anchors: anchors, to: superview, withInsets: insets)
//    }
    
    
    func pinToSuperview(anchors: UIRectEdge = .all, withInsets insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { fatalError("Cannot set constranits to a view which has no superview")
        }
        
        
    }
    
    func pin(anchors: UIRectEdge = .all, to view: UIView, withInsets insets: UIEdgeInsets = .zero) {
        
        if anchors.contains(.left) {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        }
        
        if anchors.contains(.top) {
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        }
        
        if anchors.contains(.right) {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        }
        
        if anchors.contains(.bottom) {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        }
    }
    
    
//
//    func pin(anchors: UIRectEdge = .all,to view: UIView, withInsets insets: UIEdgeInsets = .zero) {
//        if anchors.contains(.left) {
//            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
//        }
//        if anchors.contains(.top) {
//            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
//        }
//        if anchors.contains(.right) {
//            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
//        }
//        if anchors.contains(.bottom) {
//            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
//        }
//    }
//
//    func centerInSuperview() {
//        guard let superview = superview else {
//            fatalError("Can't set constraints to a view which has no superview")
//        }
//        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
//        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
//    }

    
}
