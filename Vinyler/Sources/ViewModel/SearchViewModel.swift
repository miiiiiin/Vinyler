//
//  SearchViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/17/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol SearchViewModelInput {
    var loadingAction: Action<String, Void> { get }
    var backAction: CocoaAction { get }
}

protocol SearchViewModelOutput {
}

protocol SearchViewModelType {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelInput, SearchViewModelOutput, SearchViewModelType {
    
    var input: SearchViewModelInput { return self }
    var output: SearchViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var loadingAction: Action<String, Void> = {
        Action<String, Void> { [unowned self] input in
            let viewModel = LoadingViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, barcode: nil, resourceUrl: input, artistResourceUrl: nil)
            return self.sceneCoordinator.transition(to: Scene.loading(viewModel))
        }
    }()
    
    lazy var backAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.pop(animated: true)
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

