//
//  ScanViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/03/10.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol ScanViewModelInput {
    
}

protocol ScanViewModelOutput {
    var resultSection: Observable<[SearchResultSection]> { get }
}

protocol ScanViewModelType {
    var input: ScanViewModelInput { get }
    var output: ScanViewModelOutput { get }
}

class ScanViewModel: BaseViewModel, ScanViewModelInput, ScanViewModelOutput, ScanViewModelType {
    
    var input: ScanViewModelInput { return self }
    var output: ScanViewModelOutput { return self }
    
    // MARK: - Input
    
    
    // MARK: - Output
    
    var resultSection = Observable<[SearchResultSection]>.just([])
    
    
    // MARK: - Properties
    
    var discogUseCase: DiscogsUseCaseType
    
    // MARK: - Init
    
    init(useCase: DiscogsUseCaseType = DiscogsUseCase(repository: DiscogsRepository()), sceneCoordinator: SceneCoordinatorType) {
        
        self.discogUseCase = useCase
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
