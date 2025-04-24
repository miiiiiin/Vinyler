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
    case loading(LoadingViewModel)
    case scan(ScanViewModel)
    case search(SearchViewModel)
    case artist(ArtistViewModel)
    case myPage(MyPageViewModel)
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
            return .present(vc)

        case let .login(viewModel):
            var vc = LoginViewController()
            vc.bind(to: viewModel)
            return .root(vc)
            
        case let .main(viewModel):
            var vc = MainViewController()
            vc.bind(to: viewModel)
            return .push(vc)

        case let .loading(viewModel):
            var vc = LoadingViewController()
            vc.bind(to: viewModel)
            return .present(vc)
            
        case let .scan(viewModel):
            var vc = ScanViewController()
            vc.bind(to: viewModel)
            return .push(vc)
            
        case let .search(viewModel):
            var vc = SearchViewController()
            vc.bind(to: viewModel)
            return .push(vc)
            
        case let .artist(viewModel):
            var vc = ArtistViewController()
            vc.bind(to: viewModel)
            return .present(vc)
            
        case let .myPage(viewModel):
            var vc = MyPageViewController()
            vc.bind(to: viewModel)
            return .root(vc)
        }
    }
}
