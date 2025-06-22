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
            .flatMap { result -> Single<Result<VinylLikeResponse, Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map(VinylLikeResponse.self) {
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
    
    func getLikeStatus(request: Int) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.getLikeStatus(request: request)))
            .flatMap { result -> Single<Result<VinylLikeResponse, Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map(VinylLikeResponse.self) {
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
    
    func getReviews(request: Int) -> Observable<Result<[Review], Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.getReviewsByVinyl(request: request)))
            .flatMap { result -> Single<Result<[Review], Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    if let data = try? response.map([Review].self) {
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
    
    func createReview(request: ReviewRequest) -> Observable<Result<Void, Vinyler.NetworkError>> {
        return network.request(target:MultiTarget(APIEndPoint.createReview(request: request)))
            .flatMap { result -> Single<Result<Void, Vinyler.NetworkError>> in
                switch result {
                case .success(let response):
                    return .just(.success(()))
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
            .asObservable()
    }
    
}
