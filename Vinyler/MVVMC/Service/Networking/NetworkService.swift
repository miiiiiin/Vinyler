//
//  NetworkService.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum DiscogsError: Error {
    case invalidUrl
    case noResults
    case unavailable
}

protocol NetworkServiceType {
    func request<T: Codable>(request: Request) -> Observable<Result<T, Error>>
}

final class NetworkService: NetworkServiceType {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(request: Request) -> Observable<Result<T, Error>> {
        
        debugPrint("get request: \(request.toUrlRequest()), \(request.endpoint.path), \(T.self)")
        
        return urlSession.rx.data(request: request.toUrlRequest())
            .map { data -> Result<T, Error> in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let response = try decoder.decode(T.self, from: data)
                    return .success(response)
                } catch {
                    debugPrint("no results error")
                    return .failure(DiscogsError.noResults)
                }
            }
            .observeOn(MainScheduler.asyncInstance)
    }
    
}
