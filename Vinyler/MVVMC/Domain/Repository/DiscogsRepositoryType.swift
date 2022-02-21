//
//  DiscogsRepository.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import RxSwift

protocol DiscogsRepositoryType {
//    func getSearchList(query: String) -> Single<Result<Results, Error>>
    func getSearchList(query: String) -> Observable<Results>
}
