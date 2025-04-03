//
//  VinylService.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/2/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class VinylService: VinylRepository {
    
    // MARK: - Private -
    
    private let network: VNNetworking
    private let disposeBag: DisposeBag
    
    init(network: VNNetworking) {
        self.network = network
        self.disposeBag = DisposeBag()
    }
    
    func like(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.like(request: request)))
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
