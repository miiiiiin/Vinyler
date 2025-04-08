//
//  TargetScene.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case signUp(SignUpViewModel)
    case album(AlbumViewModel)
    case login(LoginViewModel)
    case main(MainViewModel)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case let .signUp(viewModel):
            var vc = SignUpViewController()
            vc.bind(to: viewModel)
            return .root(vc)
            
        case let .album(viewModel):
            var vc = AlbumViewController()
            vc.bind(to: viewModel)
            return .root(vc)

        case let .login(viewModel):
            var vc = LoginViewController()
            vc.bind(to: viewModel)
            return .root(vc)
            
        case let .main(viewModel):
            var vc = MainViewController()
            vc.bind(to: viewModel)
            return .push(vc)

        }
    }
}
