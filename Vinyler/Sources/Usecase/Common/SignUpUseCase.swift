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
    func execute(request: TestRequest) -> Observable<Result>
}

class SignUpUseCaseImpl: SignUpUseCase {
    
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository = SignUpRepositoryImpl()) {
            self.repository = repository
    }

    func execute(request: TestRequest) -> Observable<Result> {
    }
}
