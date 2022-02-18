//
//  DiscogsRouter.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Moya
import Foundation

enum DiscogsRouter {
    case searchList(query: String)
}

extension DiscogsRouter: BaseTargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.discogs.com")!
    }
    
    var path: String {
        switch self {
        case .searchList(let query):
            return "/database/search?q=\(query)&type=release&format=Vinyl"
        }
    }
    
    var task: Task {
        switch self {
        case .searchList(let query):
//            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.httpBody)
            
//            return .requestParameters(parameters: query.toDictionary(), encoding: URLEncoding.queryString)
            
            return .requestPlain
            
        }
    }
    
}


//"REQUEST: GET, /database/search?q=w&type=release&format=Vinyl, requestParameters(parameters: [\"query\": \"w\"], encoding: Alamofire.URLEncoding(destination: Alamofire.URLEncoding.Destination.queryString, arrayEncoding: Alamofire.URLEncoding.ArrayEncoding.brackets, boolEncoding:

//
//"query allowed: Optional(\"w\")"
//"request check: https://api.discogs.com/database/search?q=w&type=release&format=Vinyl"



extension Encodable {
  func toDictionary() -> [String: Any] {
    do {
      let jsonEncoder = JSONEncoder()
      let encodedData = try jsonEncoder.encode(self)
      
      let dictionaryData = try JSONSerialization.jsonObject(
        with: encodedData,
        options: .allowFragments
      ) as? [String: Any]
      return dictionaryData ?? [:]
    } catch {
      return [:]
    }
  }
}
