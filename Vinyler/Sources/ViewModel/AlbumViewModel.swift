//
//  AlbumViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

protocol AlbumViewModelInput {
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
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
        
    }
}
