//
//  LikedListViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Toaster

protocol LikedListViewModelInput {
    var backAction: CocoaAction { get }
}

protocol LikedListViewModelOutput {
    var likedAlbums: Observable<[Release]> { get }
    
}

protocol LikedListViewModelType {
    var input: LikedListViewModelInput { get }
    var output: LikedListViewModelOutput { get }
}

class LikedListViewModel: LikedListViewModelInput, LikedListViewModelOutput, LikedListViewModelType {
    
    var input: LikedListViewModelInput { return self }
    var output: LikedListViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var backAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.pop(animated: true)
        }
    }()
    
    var likedAlbums: Observable<[Release]>    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
//    private let useCase: VinylUseCase
    
    // FIXME
    init(sceneCoordinator: SceneCoordinatorType/*, useCase: VinylUseCase*/, likedList: [Release]) {
        self.sceneCoordinator = sceneCoordinator
//        self.useCase = useCase
        self.likedAlbums = .just(likedList)
        
    }
}
