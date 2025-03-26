//
//  CommonService.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class CommonService: CommonRepository {
    
    // MARK: - Private -
    
    private let network: VNNetworking
    private let disposeBag: DisposeBag
    
    init(network: VNNetworking) {
        self.network = network
        self.disposeBag = DisposeBag()
    }
    
    func signUp(request: SignUpRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.register(request: request)))
            .flatMap { result -> Single<Result<TestResponse, Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map(TestResponse.self) {
                        return .just(.success(data))
                    } else {
                        let error = Vinyler.NetworkError.serverError(statusCode: response.statusCode, message: "JSON 디코딩 실패")
                        return .just(.failure(error))
                    }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
            .asObservable()
    }
    
    func login(request: LoginRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.login(request: request)))
            .flatMap { result -> Single<Result<TestResponse, Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map(TestResponse.self) {
                        return .just(.success(data))
                    } else {
                        let error = Vinyler.NetworkError.serverError(statusCode: response.statusCode, message: "JSON 디코딩 실패")
                        return .just(.failure(error))
                    }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
            .asObservable()
    }
    
}

