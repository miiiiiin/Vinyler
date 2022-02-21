//
//  NetworkServiceStub.swift
//  VinylerTests
//
//  Created by Running Raccoon on 2022/02/21.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
@testable import Vinyler

//enum StubType {
//    case search(String)
//}
//
//class NetworkServiceStub: NetworkServiceType {
//    
//    let stub: StubType
//
//    init(stub: StubType) {
//      self.stub = stub
//    }
//    
//    func request<T>(request: Request) -> Observable<Result<T, Error>> where T : Decodable, T : Encodable {
//        
////        do {
////          let model = try data.decode(decoder)
////          return NetworkDataResponse(json: model, result: .success, error: nil)
////        } catch {
////          return NetworkError.transform(jsonData: data)
////        }
//        
//        let bundle = Bundle(for: type(of: self))
//        guard let file = bundle.url(forResource: resource, withExtension: ext),
//          let data = try? Data(contentsOf: file) else {
//            return NetworkDataResponse(json: nil, result: .failure, error: nil)
//        }
//
//        do {
//          let model = try data.decode(decoder)
//          return NetworkDataResponse(json: model, result: .success, error: nil)
//        } catch {
//          return NetworkError.transform(jsonData: data)
//        }
//        
//    }
//    
//    
//}
