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
    
    func getSearchList(query: String) -> Observable<Result<Results, Error>> {
        let request = BaseRequest(endpoint: .search(query: query))
        return networkService.request(request: request)
    }
    
}
