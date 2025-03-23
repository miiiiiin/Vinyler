//
//  APIEndPoint.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import Moya

public enum APIEndPoint {
    case test(request: TestRequest)
    case register(request: SignUpRequest)
}

extension APIEndPoint: TargetType {
    public var baseURL: URL {
        switch self {
        case .test:
            return URL(string: Constants.API.baseURL)!
        case .register:
            return URL(string: Constants.API.baseURL + "/api/v1/user")!
        }
    }
    
    public var path: String {
        switch self {
        case .test: return "/test"
        case .register: return "/register"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .test: .post
        case .register: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .test(let request):
            return self.requestTask(request)
        case .register(let request):
            return self.requestTask(request)
        }
    }
    
    public func requestTask(_ request: Encodable) -> Task {
        let requestToJson = JSONSerializer.toJson(request)
        guard let param = requestToJson.jsonStringToDictionary else {
            return .requestPlain
        }
        return requestParam(params: param)
        
    }
    
    private func requestParam(params: [String : Any]) -> Task {
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
    
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
