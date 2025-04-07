//
//  VinylUseCase.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/2/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

protocol VinylUseCase {
    
    func search(query: String) -> Observable<[ResultItem]>
    func fetchRelease(path: String) -> Observable<Release>
    func fetchArtist(path: String) -> Observable<Artist
                                                    
    func execute(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>>
    
    func getLikeStatus(request: Int) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>>
}

class VinylUseCaseImpl: VinylUseCase {
    
    private let repository: VinylRepository
    
    init(repository: VinylRepository) {
        self.repository = repository
    }
   
    func execute(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return repository.like(request: request)
    }
    
    func getLikeStatus(request: Int) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return repository.getLike(request: request)
    }
    
    func search(query: String) -> Observable<[ResultItem]> {
        return repository.search(query: query)
    }
    
    func fetchRelease(path: String) -> Observable<Release> {
        return repository.fetchRelease(path)
    }
    
    func fetchArtist(path: String) {
        return repository.fetchArtist(path: path)
    }
}
