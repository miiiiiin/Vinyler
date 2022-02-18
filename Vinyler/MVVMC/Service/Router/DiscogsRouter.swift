//
//  DiscogsRouter.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Moya

enum DiscogsRouter {
    case searchList(query: String)
}

extension DiscogsRouter: BaseTargetType {
    var path: String {
        switch self {
        case .searchList(let query):
            return "/database/search?q=\(query)&type=release&format=Vinyl"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .searchList(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        }
    }
}
