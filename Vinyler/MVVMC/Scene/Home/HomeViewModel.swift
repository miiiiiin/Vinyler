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
    
    var searchList: Observable<Results>
    
    
    override init(sceneCoordinator: SceneCoordinatorType) {
        
        let discogsUseCase = DiscogsResultUseCase(repository: DiscogsRepository())
        
//        searchList = discogsUseCase.executeSearchList(query: "w")
//            .map { result in
//                debugPrint("search list results: \(result)")
//                return result
//            }
        
        
        searchList = discogsUseCase.executeSearchList(query: "w")
            .asObservable()
            .flatMap { result -> Observable<Results> in
                switch result {
                case let .success(response):
                    return .just(response)
                    
                case let .failure(error):
                    return .empty()
                }
            }
        
        
        
//            .map { result -> Observable<Results> in
//                debugPrint("search list results: \(result)")
//
//                if case let .success(response) = result {
//                    let items = response
//                    debugPrint("check items : \(items.toDictionary())")
//                    return .just(response)
//                }
//            }
        
//        return network.request(target: MultiTarget(NetworkService.requestCustomURL(requestUrl: request)))
//            .map { try $0.mapObject(BaseResponse.self) }
//            .asObservable()
//            .map(Result<BaseResponse, Itcha.NetworkError>.success)
//            .catchError { error in
//                guard let error = error as? Itcha.NetworkError else { return .just(.failure(.ERR_DB_NODATA)) }
//                return .just(.failure(error))
//            }
            
        
        
        
        super.init(sceneCoordinator: sceneCoordinator)
    }
}
