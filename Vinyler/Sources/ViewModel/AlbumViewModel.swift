//
//  AlbumViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action
import Toaster

protocol AlbumViewModelInput {
    var likeAction: Action<Release, Void> { get }
}

protocol AlbumViewModelOutput {
}

protocol AlbumViewModelType {
    var input: AlbumViewModelInput { get }
    var output: AlbumViewModelOutput { get }
}

class AlbumViewModel: AlbumViewModelInput, AlbumViewModelOutput, AlbumViewModelType {
    
    var input: AlbumViewModelInput { return self }
    var output: AlbumViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var likeAction: Action<Release, Void> = {
        Action<Release, Void> { [unowned self] input in
            
            let request = LikeRequest(albumInfo: input)
            
            return self.useCase.execute(request: request)
                .flatMap { result -> Observable<Void> in
                    switch result {
                    case let .success(response):
                        return .empty()
                        
                    case let .failure(error):
                        let errorResponse = error.errorDescription
                        Toast(text: errorResponse).show()
                        return .empty()
                        
                    }
                }
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
