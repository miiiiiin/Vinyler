//
//  LoginUseCase.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginUseCase {
    func execute(request: LoginRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>>
}

class LoginUseCaseImpl: LoginUseCase {
    private let repository: 
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
   
    func execute(request: LoginRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return repository.execute(request: request)
    }
}
