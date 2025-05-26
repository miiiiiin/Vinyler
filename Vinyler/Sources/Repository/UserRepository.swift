//
//  UserRepository.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/27/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func getLikedList(request: Int) -> Observable<Result<[VinylerRelease], Vinyler.NetworkError>>
}
