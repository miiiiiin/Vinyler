//
//  ReviewRequest.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/22/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct ReviewRequest: Encodable {
    let discogsId: Int64
    let rating: Int
    let content: String?
}
