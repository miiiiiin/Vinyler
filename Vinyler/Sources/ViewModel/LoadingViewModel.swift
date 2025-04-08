//
//  LoadingViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/3/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol LoadingViewModelInput {
    var albumAction: Action<Release, Void> { get }
    var artistAction: Action<Artist, Void> { get }
}

protocol LoadingViewModelOutput {
}

protocol LoadingViewModelType {
    var input: LoadingViewModelInput { get }
    var output: LoadingViewModelOutput { get }
}

class LoadingViewModel: LoadingViewModelInput, LoadingViewModelOutput, LoadingViewModelType {
    
    var input: LoadingViewModelInput { return self }
    var output: LoadingViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var albumAction: Action<Release, Void> = {
        Action<Release, Void> { [unowned self] input in
            let viewModel = AlbumViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, release: input)
            
            return self.sceneCoordinator.transition(to: Scene.album(viewModel))
        }
    }()
    
    lazy var artistAction: Action<Artist, Void> = {
        Action<Artist, Void> { [unowned self] input in
            return .just(())
        }
    }()
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
    }
}
