//
//  DiscogsUseCase.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DiscogsUseCaseType {
    func executeSearchList(query: String) -> Observable<Result<Results, Error>>
    
    
}

final class DiscogsUseCase: DiscogsUseCaseType {
    
    private let repository: DiscogsRepositoryType
    
    init(repository: DiscogsRepositoryType) {
        self.repository = repository
    }
    
    func executeSearchList(query: String) -> Observable<Result<Results, Error>>{
        return repository.getSearchList(query: query)
    }
}
