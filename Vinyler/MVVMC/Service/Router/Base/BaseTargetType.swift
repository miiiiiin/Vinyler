//
//  BaseTargetType.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Moya


protocol BaseTargetType: TargetType {

}

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: "https://api.discogs.com")!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        let httpHeaders: [String: String] = ["Content-type" : "application/vnd.discogs.v2.plaintext+json", "Authorization": "Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)"]
//        httpHeaders["User-Agent"] = String(UIDevice.iPhoneModel() + " \(String.osVersion)")
        return httpHeaders
    }
    
    
//    func requestTask(_ request: Any) -> Task {
//        debugPrint("request check : \(request)")
//        let requestTojson = JSONSerializer.toJson(request)
//        debugPrint("request to json : \(requestTojson)")
//        guard let params = requestTojson.jsonStringToDictionary else { return .requestPlain }
//        debugPrint("request task params : \(params)")
//        return requestParam(params: params)
//    }
    
//    func requestParam(params: [String : Any]) -> Task {
//        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
//    }
}
