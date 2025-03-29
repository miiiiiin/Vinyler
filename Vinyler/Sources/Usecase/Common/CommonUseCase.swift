//
//  CommonUseCase.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol CommonUseCase {
    func execute(request: SignUpRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>>
    
    func execute(request: LoginRequest) -> Observable<Result<LoginResponse, Vinyler.NetworkError>>
}

class CommonUseCaseImpl: CommonUseCase {
    
    private let repository: CommonRepository
    
    init(repository: CommonRepository) {
            self.repository = repository
    }
   
    func execute(request: SignUpRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return repository.signUp(request: request)
    }
    
    func execute(request: LoginRequest) -> Observable<Result<LoginResponse, Vinyler.NetworkError>> {
        return repository.login(request: request)
    }
}

