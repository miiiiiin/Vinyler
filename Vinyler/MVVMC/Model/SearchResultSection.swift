//
//  SearchResultSection.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/25.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import RxDataSources

struct SearchResultSection {
    var header: String
    var items: [Item]
}

extension SearchResultSection: AnimatableSectionModelType {
    
    typealias Item = SearchResult
    
    init(original: SearchResultSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}
