//
//  ObservableType+Void.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import RxSwift

//create extension function for converting observable<[any]> to observable<void>
extension ObservableType {

    func mapVoid() -> Observable<Void> {
        return map { _ in () }
    }
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
}
