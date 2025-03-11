//
//  SignUpUseCase.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol SignUpUseCase {
    func execute(request: TestRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>>
}

class SignUpUseCaseImpl: SignUpUseCase {
    
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
            self.repository = repository
    }
   
    func execute(request: TestRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return repository.execute(request: request)
    }
}

