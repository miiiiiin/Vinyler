//
//  ArtistViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/23/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Toaster

protocol ArtistViewModelInput {
    var dismissAction: CocoaAction { get }
}

protocol ArtistViewModelOutput {
}

protocol ArtistViewModelType {
    var input: ArtistViewModelInput { get }
    var output: ArtistViewModelOutput { get }
}

class ArtistViewModel: ArtistViewModelInput, ArtistViewModelOutput, ArtistViewModelType {
    
    var input: ArtistViewModelInput { return self }
    var output: ArtistViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismissAll(animated: true).asObservable().map { _ in }
        }
    }()
    

    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, artistInfo: Artist) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
    
    }

}
