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
            case 0: break
//                let viewModel = LikedListViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, likedList: self.)
            default:
                return .just(())
            }
            return .just(())
        }
    }()
    
    var menuItems: Observable<[Menu]>
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: CommonUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
        menuItems = .just([
            Menu(id: 1, icon: .emptyHeart, title: .menuLiked)
        ])
    }
}
