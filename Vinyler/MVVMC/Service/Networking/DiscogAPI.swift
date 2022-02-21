//
//  DiscogAPI.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation

protocol Request {
    var httpMethod: HttpMethod { get }
    var headers: [String: String] { get }
    var baseUrl: String { get }
    var endpoint: BaseRequest.EndPoint { get }
    var params: [String: String]? { get }
}

extension Request {
    func toUrlRequest() -> URLRequest {
        guard let baseUrl = URL(string: baseUrl),
              var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
                  fatalError("Unable to create URL or append path component \(endpoint)")
              }
        
        components.queryItems = params?.map { URLQueryItem(name: $0, value: $1) }
        guard let encodedUrlStr = components.url.flatMap { $0.absoluteString.removingPercentEncoding }, let url = URL(string: encodedUrlStr) else {
            fatalError("Unable to obtain url from components")
        }
//        debugPrint("component check: \(components.url), \(components.queryItems)")
        
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        headers.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        
        debugPrint("request check: \(request)")
        
        return request
    }
}

enum HttpMethod: String {
    case GET
}
