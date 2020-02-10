//
//  UILabel+Style.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UILabel {

    static var block: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .block
        label.textColor = .white//.dark
        return label
    }

    static var header: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .header
        label.textColor = .white//.dark
        label.numberOfLines = 0
        return label
    }

//    static var copyableHeader: CopyableLabel {
//        let label = CopyableLabel()
//        label.font = .headerTimes
//        label.textColor = .dark
//        label.numberOfLines = 0
//        return label
//    }

    static var headerLight: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .header
        label.textColor = .gray

        label.numberOfLines = 0
        return label
    }

    static var header2: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .header2
        label.textColor = .dark
        label.numberOfLines = 0
        return label
    }

    static var subheader: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .subheader
        label.textColor = .dark
        label.numberOfLines = 0
        return label
    }

    static var subheaderDark: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .subheader
        label.textColor = .dark
        label.numberOfLines = 0
        return label
    }

    static var body: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .body
        label.textColor = .dark
        label.numberOfLines = 0
        return label
    }

    static var bodyLight: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .body
        label.textColor = .gray
        return label
    }

    static var format: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .metadata
        label.textColor = .white
        return label
    }

    static var position: UILabel {
        let label = UILabel(forAutoLayout: ())
        label.font = .position
        label.textColor = .dark
        return label
    }

    func set(headerText: String, highlightPart: String? = nil) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributedTitle = NSMutableAttributedString(string: headerText,
                                                        attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                     NSAttributedString.Key.font: font,
                                                                     NSAttributedString.Key.foregroundColor: textColor])
        if let highlightPart = highlightPart {
            attributedTitle.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                           NSAttributedString.Key.foregroundColor: UIColor.mintBlue,
                                           NSAttributedString.Key.font: UIFont.headerBold ?? UIFont()],
                                          range: (headerText as NSString).range(of: highlightPart))
        }
        attributedText = attributedTitle
    }

    func set(bodyText: String,
             boldPart: String? = nil,
             oneLine: Bool = false) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = oneLine ? 0 : 12
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributedTitle = NSMutableAttributedString(string: bodyText,
                                                        attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                     NSAttributedString.Key.font: font,
                                                                     NSAttributedString.Key.foregroundColor: textColor])

        if let boldText = boldPart {
            attributedTitle.addAttribute(NSAttributedString.Key.font, value: UIFont.bodyBold ?? UIFont(), range: (bodyText as NSString).range(of: boldText))
        }

        attributedText = attributedTitle
    }
}
