//
//  MainViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/28/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol MainViewModelInput {
    var scanAction: CocoaAction { get }
    var searchAction: CocoaAction { get }
    var myPageAction: CocoaAction { get }
}

protocol MainViewModelOutput {
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput, MainViewModelType {
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var scanAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            let viewModel = ScanViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.vinylUseCase)
            return self.sceneCoordinator.transition(to: Scene.scan(viewModel))
        }
    }()
    
    lazy var searchAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            let viewModel = SearchViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.vinylUseCase)
            return self.sceneCoordinator.transition(to: Scene.search(viewModel))
        }
    }()
    
    // FIXME (사용자 정보 필요: userid)
    lazy var myPageAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            let viewModel = MyPageViewModel(sceneCoordinator: self.sceneCoordinator, useCase: UserUseCaseImpl(repository: UserService(network: VNNetworking())))
            return self.sceneCoordinator.transition(to: Scene.myPage(viewModel))
        }
    }()
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: CommonUseCase
    private let vinylUseCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.vinylUseCase = VinylUseCaseImpl(repository: VinylService(network: VNNetworking()))
        
    }
}
