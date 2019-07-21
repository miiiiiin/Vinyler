//
//  DiscogsAPI.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

enum Discogs {
    
}

//enum Error: Error {
//    case invalidUrl
//    case noResults
//    case unavailable
//}

class DiscogsAPI {
    
    private let baseURL = "https://api.discogs.com"
    
    func search(query: String, completion: @escaping ([GetResult]?) -> ()) {
//        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//            return Observable.error(DiscogsError.invalidUrl)
//        }
//        let path = base + "/database/search?q=" + query + "&type=release&format=Vinyl"
//        let searchResults: Observable<SearchResults> = request(path: path)
//        return searchResults.map { $0.results }
        
        let path = baseURL + "/database/search?q=" + query + "&type=release&format=Vinyl"
        let url: URL = URL(string: path)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let vinylList = try? JSONDecoder().decode(GetResults.self, from: data)
                
                if let vinylList = vinylList {
                    completion(vinylList.results)
                }
                
                print("results : \(String(describing: vinylList?.results))")
                print("data : \(data)")
                
//                let getResults: <GetResults.self> = request(path: path)
//                return getResults.map { $0.results }
            }
        }.resume()
    }
    
//    private func request<T: Codable>(path: String) -> <T> {
//        guard let url = URL(string: path) else {
//            return Observable.error(DiscogsError.invalidUrl)
//        }
//        var request = URLRequest(url: url)
//        request.setValue("Discogs key=\(key), secret=\(secret)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/vnd.discogs.v2.plaintext+json", forHTTPHeaderField: "Accept")
//        return URLSession.shared.rx.data(request: request).retry(3).flatMap { data -> Observable<T> in
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let release = try decoder.decode(T.self, from: data)
//                return Observable.just(release)
//            } catch {
//                return Observable.error(DiscogsError.noResults)
//            }
//            }.catchError { error in
//                let error = error as NSError
//                if error.code == -1009 {
//                    return Observable.error(DiscogsError.unavailable)
//                }
//                return Observable.error(error)
//        }
//    }
    
}

extension DiscogsAPI {
    var key: String { return "nkzSqEWNIhLJfxQKBjlX" }
    var secret: String { return "amLsRZszbLodywDtLxyeNtSVwozddAHs" }
}

