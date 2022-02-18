//
//  HomeViewModel.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol HomeViewModelInput: BaseViewModelInput {
    
}

protocol HomeViewModelOutput: BaseViewModelOutput {
    
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

class HomeViewModel: BaseViewModel, HomeViewModelInput, HomeViewModelOutput, HomeViewModelType {
    
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
    
    
    override init(sceneCoordinator: SceneCoordinatorType) {
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
