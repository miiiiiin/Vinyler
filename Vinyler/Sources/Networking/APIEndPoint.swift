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
    case like(request: LikeRequest)
    case login(request: LoginRequest)
    case getLikeStatus(request: Int)
    case getLikedList(request: Int)
    case getReviewsByVinyl(request: Int)
    case createReview(request: ReviewRequest)
}

extension APIEndPoint: TargetType {
    public var baseURL: URL {
        switch self {
        case .test:
            return URL(string: Constants.API.baseURL)!
        case .register:
            return URL(string: Constants.API.baseURL + "/api/v1/user")!
        case .like:
            return URL(string: Constants.API.baseURL + "/api/v1/vinyls")!
        case .login:
            return URL(string: Constants.API.baseURL + "/api/v1/auth")!
        case .getLikeStatus:
            return URL(string: Constants.API.baseURL + "/api/v1/vinyls")!
        case .getLikedList:
            return URL(string: Constants.API.baseURL + "/api/v1/user")!
        case .getReviewsByVinyl:
            return URL(string: Constants.API.baseURL + "/api/v1/reviews/discogs")!
        case .createReview:
            return URL(string: Constants.API.baseURL + "/api/v1/reviews/create")!
        }
    }
    
    public var path: String {
        switch self {
        case .test: return "/test"
        case .register: return "/register"
        case .like: return "/likes"
        case .login: return "/login"
        case .getLikeStatus(let request): return "/\(request)"
        case .getLikedList(let request): return "/\(request)/liked"
        case .getReviewsByVinyl(let request): return "/\(request)"
        case .createReview(let request): return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .test: .post
        case .like: .post
        case .register, .login: .post
        case .getLikeStatus, .getLikedList, .getReviewsByVinyl: .get
        case .createReview: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .test(let request):
            return self.requestTask(request)
        case .register(let request):
            return self.requestTask(request)
        case .like(let request):
            return self.requestTask(request)
        case .login(let request):
            return self.requestTask(request)
        case .getLikeStatus(let request):
            return self.requestTask(request)
        case .getLikedList(let request):
            return .requestPlain
        case .getReviewsByVinyl(let request):
            return self.requestTask(request)
        case .createReview(let request):
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
        switch self {
        case .register, .login:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            
        default:
            if let token = AuthManager.shared.accessToken {
                return [
                    "Authorization": "Bearer \(token)",
                    "Content-Type": "application/json"
                ]
            } else {
                return nil
            }
        }
    }
}
