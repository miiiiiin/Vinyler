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
import Toaster

protocol ReviewViewModelInput {
    var dismissAction: CocoaAction { get }
    var reviewAction: Action<Int, Void> { get }
    var reviewInput: BehaviorSubject<String> { get }
    var ratingValue: BehaviorRelay<Int> { get }
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
    
    lazy var reviewAction: Action<Int, Void> = {
        Action<Int, Void> { [unowned self] input in
            
            let content = try? self.reviewInput.value()
            
            let request = ReviewRequest(discogsId: Int64(input), rating: ratingValue.value, content: content)
            
            return self.useCase.createReview(request: request)
                .flatMap { result -> Observable<Void> in
                    switch result {
                    case let .success(response):
                        debugPrint("review res: \(response)")
                        return .just(response)
                        
                    case let .failure(error):
                        let errorResponse = error.errorDescription
                        Toast(text: errorResponse).show()
                        return .empty()
                    }
                }
        }
    }()
    
    
    var rating: Observable<Int> = .just(0)
    var releaseInfo: Observable<Release>
    var ratingValue: BehaviorRelay<Int> = .init(value: 0)
    
    
    var reviewInput: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
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


