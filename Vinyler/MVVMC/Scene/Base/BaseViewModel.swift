//
//  BaseViewModel.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol BaseViewModelInput {
//    var dismissAction: CocoaAction { get }
    
}


protocol BaseViewModelOutput {
    
}

protocol BaseViewModelType {
    var baseInput: BaseViewModelInput { get }
    var baseOutput: BaseViewModelOutput { get }
}


class BaseViewModel: BaseViewModelInput, BaseViewModelOutput, BaseViewModelType {
    
    var baseInput: BaseViewModelInput { return self }
    var baseOutput: BaseViewModelOutput { return self }
    
//    lazy var dismissAction: CocoaAction = {
//        CocoaAction { [unowned self] _ in
//            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
//        }
//    }()
    
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
    
}
