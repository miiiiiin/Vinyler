//
//  MainViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/28/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
}

protocol MainViewModelOutput {
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput, MainViewModelType {
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: CommonUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
    }
}
