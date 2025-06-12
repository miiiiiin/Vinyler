//
//  ReviewListViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/12/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

protocol ReviewListViewModelInput {
    var dismissAction: CocoaAction { get }
}

protocol ReviewListViewModelOutput {
}

protocol ReviewListViewModelType {
    var input: ReviewListViewModelInput { get }
    var output: ReviewListViewModelOutput { get }
}

class ReviewListViewModel: ReviewListViewModelInput, ReviewListViewModelOutput, ReviewListViewModelType {
    
    var input: ReviewListViewModelInput { return self }
    var output: ReviewListViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
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


