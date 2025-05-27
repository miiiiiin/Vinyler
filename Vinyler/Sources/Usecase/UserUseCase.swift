//
//  UserUseCase.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/27/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

protocol UserUseCase {
    func getLikedList(request: Int) -> Observable<Result<[VinylerRelease], Vinyler.NetworkError>>
}

class UserUseCaseImpl: UserUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func getLikedList(request: Int) -> Observable<Result<[VinylerRelease], Vinyler.NetworkError>> {
        return repository.getLikedList(request: request)
    }
    
}
