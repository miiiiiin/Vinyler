//
//  NetworkService.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
//import Moya

enum DiscogsError: Error {
    case invalidUrl
    case noResults
    case unavailable
}

protocol NetworkServiceType {
    //    func get<T: Decodable>(url: String, responseType: T.Type) -> Single<Result<T, Error>>
    //    func get<T: Decodable>(type: T.Type, endpoint: ServerAPI.Endpoint) -> Observable<T>
    //    func sendRequest<T: Codable>(request: String) -> Observable<T>
    
    //    func get<T: Decodable>(path: String, responseType: T.Type) -> Single<Result<T, Error>>
    
    func get<T: Decodable>(request: Request, responseType: T.Type) -> Single<Result<T, Error>>
}

final class NetworkService: NetworkServiceType {
   
    
//    func get<T>(path: String, responseType: T.Type) -> Single<Result<T, Error>> where T : Decodable {
//
//        guard let url = URL(string: path) else {
//            return .just(.failure(DiscogsError.invalidUrl))
//        }
//
//        let request = URLRequest(url: url)
//
//    }
//
    
//    func get<T>(endpoint: DiscogAPI.Endpoint, responseType: T.Type) -> Single<Result<T, Error>> where T : Decodable {
//
//        guard let url = URL(string: "\(DiscogAPI.baseURL)\(endpoint.path)") else {
//            return .just(.failure(DiscogsError.invalidUrl))
//        }
//
//        let requst = URLRequest(url: url)
//
//        return urlSession.shared.rx
//            .data(request: request)
//
        
//        return urlSession.rx.data(request: request.toUrlRequest())
        //            .map { data in
        //                try JSONDecoder().decode(T.self, from: data)
        //            }
        //            .observeOn(MainScheduler.asyncInstance)
        
        
//        return URLSession.shared.rx
        //            .data(request: request)
        //            .map { data in
        //                do {
        //                    let response = try JSONDecoder().decode(T.self, from: data)
        //                    return .success(response)
        //                } catch {
        //                    return .failure(HTTPServiceError.invalidResponse)
        //                }
        //            }
        //            .observe(on: MainScheduler.asyncInstance)
        //            .asSingle()
        
        
//
//    }
    
    func get<T: Decodable>(request: Request, responseType: T.Type) -> Single<Result<T, Error>> {
        
//        guard let url = URL(string: "\(DiscogAPI.baseURL)\(endpoint.path)") else {
//            return .just(.failure(DiscogsError.invalidUrl))
//        }
        
        debugPrint("get request: \(request.endpoint.path), \(T.self)")
        
        return URLSession.shared.rx.data(request: request.toUrlRequest())
            .map { data -> Result<T, Error> in
                
                debugPrint("decode check: \(try JSONDecoder().decode(T.self, from: data))")
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    return .success(response)
                } catch {
                    debugPrint("failure drror")
                    return .failure(DiscogsError.unavailable)
                }
            }
            .observeOn(MainScheduler.asyncInstance)
            .asSingle()
            
    }
    
    
}




//class HTTPService: HTTPServiceType {
//    func get<T: Decodable>(url: String, responseType: T.Type) -> Single<Result<T, Error>> {
//        guard let url = URL(string: url) else {
//            return .just(.failure(HTTPServiceError.invalidUrl))
//        }
//
//        let request = URLRequest(url: url)
//
//        return URLSession.shared.rx
//            .data(request: request)
//            .map { data in
//                do {
//                    let response = try JSONDecoder().decode(T.self, from: data)
//                    return .success(response)
//                } catch {
//                    return .failure(HTTPServiceError.invalidResponse)
//                }
//            }
//            .observe(on: MainScheduler.asyncInstance)
//            .asSingle()
//    }
//}



//final class APIService: APIServiceProtocol {
//
//    private let urlSession: URLSession
//
//    init(urlSession: URLSession) {
//        self.urlSession = urlSession
//    }
//
//    func sendRequest<T: Codable>(request: Request) -> Observable<T> {
//        return urlSession.rx.data(request: request.toUrlRequest())
//            .map { data in
//                try JSONDecoder().decode(T.self, from: data)
//            }
//            .observeOn(MainScheduler.asyncInstance)
//    }
//
//    func downloadImage(request: ImageDownloadRequest) -> Observable<UIImage> {
//        return Observable.create { observer in
//            DispatchQueue.global(qos: .utility).async {
//                if let url = request.url,
//                   let data = try? Data(contentsOf: url),
//                   let img = UIImage(data: data) {
//                    observer.onNext(img)
//                } else {
//                    observer.onNext(Asset.Images.popcorn.image)
//                }
//            }
//            return Disposables.create()
//        }
//    }
//
//}

//protocol Request {
//    var httpMethod: HttpMethod { get }
//    var headers: [String: String] { get }
//    var baseUrl: String { get }
//    var path: String { get }
//    var params: [String: String] { get }
//}
//
//extension Request {
//    func defaultHeaders() -> [String: String] {
//        return ["Content-Type": "application/json"]
//    }
//
//    func defaultParams() -> [String: String] {
//        return ["api_key": APIUtils.apiKey]
//    }
//}
//
//extension Request {
//    func toUrlRequest() -> URLRequest {
//        guard let baseUrl = URL(string: baseUrl),
//            var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
//            fatalError("Unable to create URL or append path component \(path)")
//        }
//
//        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
//        guard let url = components.url else {
//            fatalError("Unable to obtain url from components")
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        headers.forEach { request.addValue($0, forHTTPHeaderField: $1) }
//        return request
//    }
//}
//
//enum HttpMethod: String {
//    case GET
//}
