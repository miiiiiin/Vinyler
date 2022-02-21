//
//  BaseRequest.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation

class BaseRequest: Request {
    
    enum EndPoint {
        case search(query: String)
        
        var path: String {
            switch self {
            case .search(let query):
                return "/database/search?q=\(query)&type=release&format=Vinyl"
            }
        }
    }
    
    var httpMethod: HttpMethod = .GET
    
    var baseUrl: String = "https://api.discogs.com"
    
    var endpoint: EndPoint
    
    var params: [String : String]?
    
    var headers: [String : String] {
        return ["Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)": "Authorization",
                "application/vnd.discogs.v2.plaintext+json": "Accept"
        ]
    }
    
    init(httpMethod: HttpMethod = .GET, endpoint: EndPoint, params: [String: String]? = nil) {
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.params = params
    }
}
