//
//  UITextView+Extension.swift
//  Vinyler
//
//  Created by Min on 2020/01/25.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    func set(bodyText: String,
             boldPart: String? = nil,
             underlineParts: [String] = [],
             highlightPart: String? = nil) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributedTitle = NSMutableAttributedString(string: bodyText,
                                                        attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle,
                                                                     NSAttributedString.Key.font : font ?? UIFont(),
                                                                     NSAttributedString.Key.foregroundColor : textColor ?? UIColor()])
        
        if let boldText = boldPart {
            attributedTitle.addAttribute(NSAttributedString.Key.font, value: UIFont.bodyBold ?? UIFont(), range: (bodyText as NSString).range(of: boldText))
        }
        underlineParts.forEach { underlineText in
            attributedTitle.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (bodyText as NSString).range(of: underlineText))
        }
        if let highlightPart = highlightPart {
            attributedTitle.addAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                           NSAttributedString.Key.foregroundColor : UIColor.black,
                                           NSAttributedString.Key.font : UIFont.bodyBold ?? UIFont()],
                                          range: (bodyText as NSString).range(of: highlightPart))
        }
        
        attributedText = attributedTitle
    }
    
    func tapped(oneOf texts: [String]) -> Observable<String> {
        let tap = UITapGestureRecognizer()
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        return tap.rx.event.map { $0.didTap(oneOf: texts)        }.filterNil()
    }
}
