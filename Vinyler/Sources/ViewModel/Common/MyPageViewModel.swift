//
//  MyPageViewModel.swift
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

protocol MyPageViewModelInput {
    var backAction: CocoaAction { get }
    var nextAction: Action<Int, Void> { get }
}

protocol MyPageViewModelOutput {
    var menuItems: Observable<[Menu]> { get }
}

protocol MyPageViewModelType {
    var input: MyPageViewModelInput { get }
    var output: MyPageViewModelOutput { get }
}

class MyPageViewModel: MyPageViewModelInput, MyPageViewModelOutput, MyPageViewModelType {
    
    var input: MyPageViewModelInput { return self }
    var output: MyPageViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var backAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.pop(animated: true)
        }
    }()
    
    lazy var nextAction: Action<Int, Void> = {
        Action<Int, Void> { [unowned self] id in
            switch id {
            case 1:
                return self.useCase.getLikedList(request: 2)
                    .flatMap { result -> Observable<Void> in
                        switch result {
                        case let .success(response):
                            let viewModel = LikedListViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, likedList: response)
                            return self.sceneCoordinator.transition(to: Scene.likedList(viewModel))
                        case let .failure(error):
                            let errorResponse = error.errorDescription
                            Toast(text: errorResponse).show()
                            return .empty()
                        }
                    }
                
            default:
                return .just(())
            }
            return .just(())
        }
    }()
    
    var menuItems: Observable<[Menu]>
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: UserUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: UserUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
        menuItems = .just([
            Menu(id: 1, icon: .emptyHeart, title: .menuLiked)
        ])
    }
}
