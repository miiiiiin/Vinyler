//
//  NetworkService.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

//import Alamofire
//import Moya
//import RxSwift
//
//protocol NetworkServiceType {
//    func request<T: TargetType>(to target: T/*, file: StaticString, function: StaticString, line: UInt*/) -> Single<Response>
//}
//
//struct NetworkService: NetworkServiceType {
//
//    func request<T>(to target: T/*, file: StaticString = #file, function: StaticString = #function, line: UInt = #line*/) -> Single<Response> where T : TargetType {
//
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 30
////        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
//        let session = Session(configuration: configuration)
//
//
////        let endPointClosure = { (target: T) -> Endpoint in
////            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
////
////            debugPrint("default endpoint check: \(defaultEndpoint)")
////
////            return defaultEndpoint.adding(newHTTPHeaderFields: [
////                "Authorization": "Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)",
////                "Accept": "application/vnd.discogs.v2.plaintext+json"
////            ])
////        }
//
//
//        let provider: MoyaProvider<T> = MoyaProvider(endpointClosure: MoyaProvider<T>.defaultEndpointMapping, requestClosure: MoyaProvider<T>.defaultRequestMapping, stubClosure: MoyaProvider.neverStub,  session: session, plugins: [NetworkLoggerPlugin()], trackInflights: false)
//
//        let requestString = "\(target.method.rawValue), \(target.path), \(target.task)"
//
//        debugPrint("taraget check: \(target.method.rawValue), \(target.path), \(target.task), \(target.headers), \(target.baseURL)")
//
//        debugPrint("endpoint closure: \(provider.endpoint(target).httpHeaderFields)")
//
//
//        return provider.rx.request(target)
//            .filterSuccessfulStatusCodes()
//            .do(onSuccess: { value in
//                debugPrint("SUCCESS: \(requestString), (\(value.statusCode))")
//            }, onError: { error in
//                debugPrint("onerror: \(error)")
//
//                if let response = (error as? MoyaError)?.response {
//                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
//                        let message = "FAILURE: \(requestString), \(response.statusCode), \(jsonObject)"
//                        debugPrint("MoyaError: \(message)")
//                    } else if let rawString = String(data: response.data, encoding: .utf8) {
//                        let message = "FAILURE: \(requestString), \(response.statusCode), \(rawString)"
//                        debugPrint("\(message)")
//                    }
//                }
//            }, onSubscribe: {
//                debugPrint("REQUEST: \(requestString)")
//            }
//        )
//    }
//}