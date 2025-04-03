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
    func execute(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>>
}

class VinylUseCaseImpl: VinylUseCase {
    
    private let repository: VinylRepository
    
    init(repository: VinylRepository) {
            self.repository = repository
    }
   
    func execute(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>> {
        return repository.like(request: request)
    }
}
