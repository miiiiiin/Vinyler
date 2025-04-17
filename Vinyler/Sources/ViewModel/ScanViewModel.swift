//
//  ScanViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/17/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol ScanViewModelInput {
    var loadingAction: Action<String, Void> { get }
    var backAction: CocoaAction { get }
}

protocol ScanViewModelOutput {
}

protocol ScanViewModelType {
    var input: ScanViewModelInput { get }
    var output: ScanViewModelOutput { get }
}

class ScanViewModel: ScanViewModelInput, ScanViewModelOutput, ScanViewModelType {
    
    var input: ScanViewModelInput { return self }
    var output: ScanViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var loadingAction: Action<String, Void> = {
        Action<String, Void> { [unowned self] input in
            let viewModel = LoadingViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, barcode: input, resourceUrl: nil, artistResourceUrl: nil)
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

