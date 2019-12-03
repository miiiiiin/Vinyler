//
//   UITapGestureRecognizer+UILabel.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {

    func didTap(oneOf texts: [String]) -> String? {
        guard let textView = view as? UITextView,
            let attributedText = textView.attributedText else { return nil }
        let rangesAndTexts = texts.map { text -> (NSRange, String) in
            let range = (attributedText.string as NSString).range(of: text)
            return (range, text)
        }

        let layoutManager = textView.layoutManager

        let locationOfTouchInLabel = location(in: textView)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInLabel, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return rangesAndTexts.filter { (range, _) in
            return NSLocationInRange(indexOfCharacter, range)
        }.first?.1
    }
}
