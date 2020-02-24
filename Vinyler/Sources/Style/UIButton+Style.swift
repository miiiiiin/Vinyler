//
//  UIButton+Style.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UIButton {

    static var search: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.backgroundColor = .purplishDarkBlue
        button.setTitle(.search, for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .header
        button.layer.shadowRadius = 8/2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
        button.layer.shadowOpacity = 0.8
        return button
    }

    static var close: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(.close, for: .normal)
        button.tintColor = style.Colors.tint
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }

    static var cancel: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setBackgroundImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        button.tintColor = .dark
        button.widthAnchor.constraint(equalToConstant: 77).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }

    static var scanBack: UIButton {
           let button = UIButton(forAutoLayout: ())
           button.setImage(.scanBack, for: .normal)
           button.widthAnchor.constraint(equalToConstant: 30).isActive = true
           button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
           return button
       }
    
    static var back: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(.back, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.tintColor = style.Colors.tint
        return button
    }

    static var more: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(.more, for: .normal)
        button.tintColor = style.Colors.tint
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
}
