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
    
    func getLikedList(request: Int) -> Observable<Result<[VinylerRelease], Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.getLikedList(request: request)))
            .flatMap { result -> Single<Result<[VinylerRelease], Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    do {
                        let data = try response.map([VinylerRelease].self)
                        return .just(.success(data))
                    } catch {
                        let error = Vinyler.NetworkError.serverError(statusCode: response.statusCode, message: "JSON 디코딩 실패: \(error.localizedDescription)")
                        return .just(.failure(error))
                    }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
            .asObservable()
    }
}
