//
//  BaseRequest.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation

class BaseRequest: Request {
    
    var httpMethod: HttpMethod = .GET
    
    var baseUrl: String = "https://api.discogs.com"
    
    var endpoint: EndPoint
    
    var params: [String : String]
    
    var headers: [String : String] {
        let httpHeaders: [String : String] = ["Authorization": "Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)",
            "Accept": "application/vnd.discogs.v2.plaintext+json"
        ]
        return httpHeaders
    }
    
    init(httpMethod: HttpMethod = .GET, endpoint: EndPoint, params: [String: String]) {
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.params = params
    }
}
