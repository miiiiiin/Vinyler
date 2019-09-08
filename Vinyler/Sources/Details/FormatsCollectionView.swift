//
//  FormatsCollectionView.swift
//  Vinyler
//
//  Created by 민송경 on 31/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

struct FormatsSection {
    var title: String?
    var items: [String]

    init(title: String? = nil, items: [String]) {
        self.title = title
        self.items = items
    }
}

class FormatsCollectionView: UICollectionView {

}
