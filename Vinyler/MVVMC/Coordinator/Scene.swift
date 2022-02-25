//
//  Scene.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case home(HomeViewModel)
    case search(SearchByTextViewModel)
    
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .home(let viewModel):
            var vc = HomeViewController()
            vc.bind(to: viewModel)
            return .root(vc)
            
        case .search(let viewModel):
            var vc = SearchByTextViewController()
            vc.bind(to: viewModel)
            return .present(vc, true)
        }
    }
}
