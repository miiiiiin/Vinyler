//
//  UserSignUpService.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class UserSignUpService: SignUpRepository {

    // MARK: - Private -
    
    private let network: VNNetworking
    private let disposeBag: DisposeBag
    
    init(network: VNNetworking) {
        self.network = network
        self.disposeBag = DisposeBag()
    }
    
    func execute(request: SignUpRequest) -> Observable<Result<TestResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.register(request: request)))
            .map { response -> Result<TestResponse, Vinyler.NetworkError> in
                do {
                    let data = try response.map(TestResponse.self)
                    return .success(data)
                } catch {
                    return .failure(.decodingError)
                }
            }
            .asObservable()
            .catch { error in
                let networkError = error as? Vinyler.NetworkError ?? .databaseNoData
                return .just(Result<TestResponse, Vinyler.NetworkError>.failure(networkError))
            }
    }
}
