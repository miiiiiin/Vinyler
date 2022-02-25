//
//  HomeViewModel.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Action
import RxSwift
import RxCocoa
import CoreMedia

protocol HomeViewModelInput: BaseViewModelInput {
    var moveAction: CocoaAction { get }
}

protocol HomeViewModelOutput: BaseViewModelOutput {
    var searchList: Observable<Results> { get }
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

class HomeViewModel: BaseViewModel, HomeViewModelInput, HomeViewModelOutput, HomeViewModelType {
    
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
    
    
    // MARK: - Input
    
    lazy var moveAction: CocoaAction = {
        return CocoaAction { [unowned self] _ in
            let viewModel = SearchByTextViewModel(sceneCoordinator: self.sceneCoordinator)
            return self.sceneCoordinator.transition(to: Scene.search(viewModel)).map { _ in }
        }
    }()
    
    // MARK: - Output
    
    var searchList: Observable<Results>
    
    // MARK: - Init
    
    override init(sceneCoordinator: SceneCoordinatorType) {
        
        let discogsUseCase = DiscogsUseCase(repository: DiscogsRepository())
        
        searchList = discogsUseCase.executeSearchList(query: "w")
            .flatMap { result -> Observable<Results> in
                switch result {
                case let .success(response):
                    return .just(response)

                case let .failure(error):
                    return .empty()
                }
            }
        
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
