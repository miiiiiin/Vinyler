//
//  Results.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxDataSources

struct Results: Codable, Equatable {
    let results: [SearchResult]
}

struct SearchResult: Codable, Equatable {
    let resourceUrl: String
    let format: [String]
    let label: [String]
    let title: String
    let thumb: String
    let country: String
    let year: String?
    let uri: String?
}

extension SearchResult: IdentifiableType {
    var identity: String { // FIXME: - ID로 수정 필요
        return resourceUrl
    }
}
