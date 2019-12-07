//
//  UIButton+Style.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit

extension UIButton {

//    static var back: UIButton {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
//        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        return button
//    }
//
//    static var camera: UIButton {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
//        button.tintColor = .mintBlue
//        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        return button
//    }
//
//    static var close: UIButton {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
//        button.tintColor = .dark
//        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        return button
//    }
//
//    static var list: UIButton {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
//        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        return button
//    }
//
//    static var myVinyl: UIButton {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "myVinyls"), for: .normal)
//        button.tintColor = .mintBlue
//        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        return button
//    }

    static var search: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.backgroundColor = .coral
        button.titleLabel?.textColor = .white
        button.setTitle(.search, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = .header
        button.layer.shadowRadius = 8/2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
        button.layer.shadowOpacity = 0.8
        return button
    }
    
    static var camera: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.tintColor = .gray
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.264).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }

    static var close: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(.close, for: .normal)
        button.tintColor = .dark
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

    static var back: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(.back, for: .normal)
        button.tintColor = .dark
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }

    static var more: UIButton {
        let button = UIButton(forAutoLayout: ())
        button.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        button.tintColor = .dark
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
}
