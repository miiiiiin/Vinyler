//
//  VinylLikeResponse.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/3/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct VinylLikeResponse: Decodable {
    var vinylId: Int64?
    var userId: Int64?
    var isLiking: Bool?
}
