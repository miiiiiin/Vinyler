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
    
    func request(target: Target) -> Single<Result<Response, Vinyler.NetworkError>> {
        
        let requestString = "\(target.headers), \(target.method.rawValue), \(target.baseURL)\(target.path), \(target.task)"
        
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map { response -> Result<Response, Vinyler.NetworkError> in
                
                debugPrint("response check: \(response)")
                
                if (200..<300).contains(response.statusCode) {
                    debugPrint("[SUCCESS]: \(requestString), \(response.statusCode)")
                    return .success(response)
                    
                } else {
                    let error = Vinyler.NetworkError.serverError(statusCode: response.statusCode, message: nil)
                    return .failure(error)
                }
            }.catch { error in
                debugPrint("[ERROR]: \(error.localizedDescription)")
                
                if let moyaError = error as? MoyaError, let response = moyaError.response {
                    let message = try? response.mapJSON(failsOnEmptyData: false)
                    let failureMessage = "[FAILURE]: \(requestString), \(response.statusCode), \(message ?? "No Response")"
                    debugPrint("[MoyaError]: \(failureMessage)")
                    
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        debugPrint("Extracted message: \(errorResponse.message)")
                        let error = Vinyler.NetworkError(statusCode: response.statusCode, message: errorResponse.message)
                        return .just(.failure(error ?? .unknownError))
                        
                    } catch {
                        debugPrint("Failed to decode JSON: \(error)")
                    }
                    
                }
                
                return .just(.failure(.unknownError))
            }
    }
}
