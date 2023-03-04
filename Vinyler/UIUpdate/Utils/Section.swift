//
//  Section.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/08/30.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import RxDataSources

struct Section<T> {
    
    var title: String?
    var items: [T]
    
    init(items: [T], title: String? = nil) {
        self.title = title
        self.items = items
    }
}

extension Section: SectionModelType {
    
    typealias Item = T
    
    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}
