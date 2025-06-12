//
//  UserSignUpLoginRepository.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
/**
 데이터 소스(DB, API 등)를 관리하는 계층
 Service를 호출하여 네트워크 요청 수행
 */

protocol CommonRepository {
    
    func signUp(request: SignUpRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>>
    
    func login(request: LoginRequest) -> Observable<Result<LoginResponse, Vinyler.NetworkError>>
}

