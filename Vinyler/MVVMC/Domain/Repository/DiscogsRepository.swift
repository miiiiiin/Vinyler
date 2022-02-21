//
//  DiscogsRepository.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Moya
import RxSwift

final class DiscogsRepository: DiscogsRepositoryType {
    
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }
    
//    func getSearchList(query: String) -> Single<Result<Results, Error>> {
      
//        return networkService.request(to: DiscogsRouter.searchList(query: query))
//            .map { try $0.map(Results.self) }
//            .asObservable()
        
//        let request = BaseRequest(path: .search(query: query))
//
//        return networkService.get(request: request, responseType: Results.Type)
        
//        let request = BaseRequest(endpoint: .search(query: query), params: [:])
        
//        return networkService.get(request: request, responseType: Results.self)
        
//        return networkService.request(request: request)
//
//    }
    
    func getSearchList(query: String) -> Observable<Results> {
        let request = BaseRequest(endpoint: .search(query: query))
        return networkService.request(request: request)
    }
    
}
