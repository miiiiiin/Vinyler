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
    
    func getLike(request: Int) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return network.request(target: MultiTarget(APIEndPoint.getLike(request: request)))
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
    
    func search(query: String) -> Observable<[ResultItem]> {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
             return Observable.error(RequestError.invalidUrl)
        }

        let path = Constants.DiscogsAPI.baseURL + "/database/search?q=" + query + "&type=release&format=Vinyl"
        let result: Observable<Results> = request(path: path)
        return result.map { $0.results }
    }
    
    func fetchRelease(path: String) -> Observable<Release> {
        return request(path: path)
    }
    
    func fetchArtist(path: String) -> Observable<Artist> {
        return request(path: path)
    }
    
    private func request<T: Codable>(path: String) -> Observable<T> {

        guard let url = URL(string: path) else {
            return Observable.error(RequestError.invalidUrl)
        }

        var request = URLRequest(url: url)
        request.setValue("Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.discogs.v2.plaintext+json", forHTTPHeaderField: "Accept")

        return URLSession.shared.rx.data(request: request).flatMap { data -> Observable<T> in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let release = try decoder.decode(T.self, from: data)
                    return Observable.just(release)
                } catch {
                    return Observable.error(RequestError.noResults)
                }
        }.catchError { error in
                let error = error as NSError
                print("search error : \(error.localizedDescription)")
                return Observable.error(error)
        }
    }
}
