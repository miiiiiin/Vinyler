//
//  UserService.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/27/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class UserService: UserRepository {
    
    // MARK: - Private -
    
    private let network: VNNetworking
    private let disposeBag: DisposeBag
    
    init(network: VNNetworking) {
        self.network = network
        self.disposeBag = DisposeBag()
    }
    
    func getLikedList(request: Int) -> Observable<Result<[Release], Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.getLikedList(request: request)))
            .flatMap { result -> Single<Result<[Release], Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map([Release].self) {
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
