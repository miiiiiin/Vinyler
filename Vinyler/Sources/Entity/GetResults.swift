//
//  GetResults.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

struct GetResults: Codable {
    let results: [GetResult]
}

struct GetResult: Codable {
    let resourceUrl: String
    let format: [String]
    let labels: [String]
    let title: String
    let thumb: String
    let country: String
    let year: String?
}
