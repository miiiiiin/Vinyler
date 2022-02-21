//
//  NetworkServiceMock.swift
//  VinylerTests
//
//  Created by Running Raccoon on 2022/02/21.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
@testable import Vinyler

class NetworkServiceMock: NetworkServiceType {
    
    var responses: [String: Any] = [:]
    
    func request<T>(request: Request) -> Observable<Result<T, Error>> where T : Decodable, T : Encodable {
//        let path = request.baseUrl + (request.path ?? "")
//        return responses[path] as? Observable<UIImage> ??  Observable.error(ApiError.fail)
        
//        responses[request.path] as? Observable<T> ?? Observable.error(ApiError.fail)
        
        let path = request.baseUrl + (request.endpoint.path)
        return responses[path] as? Observable<Result<T, Error>> ?? .empty()
    }
}
