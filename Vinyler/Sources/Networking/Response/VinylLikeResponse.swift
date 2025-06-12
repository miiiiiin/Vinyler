//
//  VinylLikeResponse.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/3/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct VinylLikeResponse: Decodable {
    var vinylId: Int64
    var userId: Int64
    var isLiking: Bool
    
    enum CodingKeys: String, CodingKey {
        case vinylId
        case userId
        case isLiking = "is_liking"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vinylId = try container.decode(Int64.self, forKey: .vinylId)
        userId = try container.decode(Int64.self, forKey: .userId)
        isLiking = try container.decodeIfPresent(Bool.self, forKey: .isLiking) ?? false
    }
}
