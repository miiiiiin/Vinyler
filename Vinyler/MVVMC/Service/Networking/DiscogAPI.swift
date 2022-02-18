//
//  DiscogAPI.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation

//class DiscogAPI {
//
//    static let baseURL = "https://api.discogs.com"
//
//    enum Endpoint {
//        case search(query: String)
//
//        var path: String {
//            switch self {
//            case .search(let query):
//                return "/database/search?q=\(query)&type=release&format=Vinyl"
//            default: return "/\(self)"
//            }
//        }
//    }
//}

enum EndPoint {
    case search(query: String)
    
    var path: String {
        switch self {
        case .search(let query):
            return "/database/search?q=\(query)&type=release&format=Vinyl"
            
        default:
            return ""
        }
    }
}

protocol Request {
    var httpMethod: HttpMethod { get }
    var headers: [String: String] { get }
    var baseUrl: String { get }
    var endpoint: EndPoint { get }
    var params: [String: String] { get }
}

extension Request {
    func defaultHeaders() -> [String: String] {
        return ["Authorization": "Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)",
            "Accept": "application/vnd.discogs.v2.plaintext+json"
        ]
    }
}

extension Request {
    func toUrlRequest() -> URLRequest {
        guard let baseUrl = URL(string: baseUrl),
              var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL or append path component \(endpoint)")
        }
        
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else {
            fatalError("Unable to obtain url from components")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        headers.forEach { request.addValue($0, forHTTPHeaderField: $1) }
        
        debugPrint("header check: \(headers), \(request)")
        
        return request
    }
}

enum HttpMethod: String {
    case GET
}
