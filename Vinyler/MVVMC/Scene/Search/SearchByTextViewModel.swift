//
//  SearchByTextViewModel.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/25.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol SearchByTextViewModelInput {
    
}

protocol SearchByTextViewModelOutput {
    var resultSection: Observable<[SearchResultSection]> { get }
}

protocol SearchByTextViewModelType {
    var input: SearchByTextViewModelInput { get }
    var output: SearchByTextViewModelOutput { get }
}

class SearchByTextViewModel: BaseViewModel, SearchByTextViewModelInput, SearchByTextViewModelOutput, SearchByTextViewModelType {
    
    var input: SearchByTextViewModelInput { return self }
    var output: SearchByTextViewModelOutput { return self }
    
    // MARK: - Input
    
    
    // MARK: - Output
    
    var resultSection = Observable<[SearchResultSection]>.just([])
    
    
    // MARK: - Properties
    
    var discogUseCase: DiscogsUseCaseType
    
    // MARK: - Init
    
    init(useCase: DiscogsUseCaseType = DiscogsUseCase(repository: DiscogsRepository()), sceneCoordinator: SceneCoordinatorType) {
        
        self.discogUseCase = useCase
        
        super.init(sceneCoordinator: sceneCoordinator)

        self.resultSection = searchByText(query: "w")
            .flatMap { items -> Observable<[SearchResultSection]> in
                let section = [SearchResultSection(header: "SearchResults", items: items)]
                return .just(section)
            }
    }
    
    func searchByText(query: String) -> Observable<[SearchResult]> {
        return self.discogUseCase.executeSearchList(query: query)
            .flatMap { result -> Observable<[SearchResult]> in
                switch result {
                case .success(let response):
                    return .just(response.results)
                    
                case .failure(let error):
                    return .just([])
                }
            }
    }
}
