//
//  VinylRepository.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/2/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

protocol VinylRepository {
    func like(request: LikeRequest) -> Observable<Result<VinylLikeResponse, Vinyler.NetworkError>>
    
    
}
