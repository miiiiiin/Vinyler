//
//  AnimationView+Style.swift
//  Vinyler
//
//  Created by Running Raccoon on 2019/12/19.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Lottie

extension AnimationView {
    static var animationView: AnimationView = {
        let anim = AnimationView(forAutoLayout: ())
        anim.translatesAutoresizingMaskIntoConstraints = false
        anim.frame.size = CGSize(width: 50, height: 50)
        anim.sizeToFit()
        anim.backgroundBehavior = .pauseAndRestore
        anim.animation = Animation.named("fluttering")
        return anim
    }()
}
