//
//  UITextView+Extension.swift
//  Vinyler
//
//  Created by Min on 2020/01/25.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import UIKit

extension UITextView {
    
    static var body: UITextView {
        let textView = UITextView(forAutoLayout: ())
        textView.font = .body
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }
    
    static var header: UITextView {
        let textView = UITextView(forAutoLayout: ())
        textView.font = .header
        textView.textColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }
}
