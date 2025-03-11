//
//  APIClient.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/10/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Moya

typealias VNNetworking = APIClient<MultiTarget>

final class APIClient<Target: TargetType>: MoyaProvider<Target> {
    
    // MARK: - Init -
    
    init() {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 20
        super.init()
    }
    
    func request(target: Target) -> Single<Response> {
        
        let requestString = "\(target.method.rawValue), \(target.path), \(target.task)"
        
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                debugPrint("[SUCCESS]: \(requestString), \(value.statusCode)")
            }, onError: { error in
                debugPrint("[ERROR]: \(error)")
                let message = error.localizedDescription
                
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let failureMesssage = "[FAILURE]: \(requestString), \(response.statusCode), \(jsonObject)"
                        debugPrint("[MoyaError]: \(message)\n\(failureMesssage)")
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "[FAILURE]: \(requestString), \(response.statusCode), \(rawString)"
                        debugPrint(message)
                    }
                }
            })
    }
    
}
