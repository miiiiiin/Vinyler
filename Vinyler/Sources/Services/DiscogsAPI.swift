//
//  DiscogsAPI.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

class DiscogsAPI {

    private let baseURL = "https://api.discogs.com"
    let disposeBag = DisposeBag()

    func search(query: String) -> Observable<[SearchResult]> {

        debugPrint("query allowed: \(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))")
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
             return Observable.error(DiscogsError.invalidUrl)
        }
//
//        let path = baseURL + "/database/search?q=" + query + "&type=release&format=Vinyl"
//        let result: Observable<Results> = request(path: path)
//        return result.map { $0.results }
        
        let discogsUseCase = DiscogsResultUseCase(repository: DiscogsRepository())
        
        let results = discogsUseCase.executeSearchList(query: "w")
            .map { $0.results }
            .map { items -> [SearchResult] in
                debugPrint("items count: \(items)")
                return items
            }
        
        return results

    }

    func fetchRelease(_ path: String) -> Observable<Release> {
        return request(path: path)
    }

    func fetchArtist(path: String) -> Observable<Artist> {
        return request(path: path)
    }

    private func request<T: Codable>(path: String) -> Observable<T> {

        guard let url = URL(string: path) else {
            return Observable.error(DiscogsError.invalidUrl)
        }

        var request = URLRequest(url: url)
        request.setValue("Discogs key=\(Constants.Discogs.discogKey), secret=\(Constants.Discogs.discogSecret)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.discogs.v2.plaintext+json", forHTTPHeaderField: "Accept")

        debugPrint("request check: \(request)")
        
        return URLSession.shared.rx.data(request: request).flatMap { data -> Observable<T> in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let release = try decoder.decode(T.self, from: data) /*try JSONDecoder().decode(T.self, from: data)*/
//                    print("release : \(release)")

                    return Observable.just(release)
                } catch {
                    return Observable.error(DiscogsError.noResults)
                }
        }.catchError { error in
                let error = error as NSError
                print("search error : \(error.localizedDescription)")
                return Observable.error(error)
        }
    }
    
    
}
