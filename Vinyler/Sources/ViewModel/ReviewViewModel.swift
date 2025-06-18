//
//  ReviewViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/18/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//


import Foundation
import RxCocoa
import RxSwift
import Action

protocol ReviewViewModelInput {
    var dismissAction: CocoaAction { get }
}

protocol ReviewViewModelOutput {
    var rating: Observable<Int> { get }
    var releaseInfo: Observable<Release> { get }
}

protocol ReviewViewModelType {
    var input: ReviewViewModelInput { get }
    var output: ReviewViewModelOutput { get }
}

class ReviewViewModel: ReviewViewModelInput, ReviewViewModelOutput, ReviewViewModelType {
    
    var input: ReviewViewModelInput { return self }
    var output: ReviewViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
        }
    }()
    
    
    var rating: Observable<Int> = .just(0)
    var releaseInfo: Observable<Release>
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, rating: Int, release: Release) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.rating = .just(rating)
        self.releaseInfo = .just(release)
    }
}


