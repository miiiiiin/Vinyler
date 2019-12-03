//
//  FormatsCollectionView.swift
//  Vinyler
//
//  Created by 민송경 on 31/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

struct FormatsSection {
    var title: String?
    var items: [String]

    init(title: String? = nil, items: [String]) {
        self.title = title
        self.items = items
    }
}

extension FormatsSection: SectionModelType {
    typealias Item = String
    
    init(original: FormatsSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class FormatsCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
           super.init(frame: frame, collectionViewLayout: layout)
           setup()
    }
       
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setup()
    }
    
    private func setup() {
          translatesAutoresizingMaskIntoConstraints = false
          backgroundColor = .clear
          clipsToBounds = false
          if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
              layout.scrollDirection = .horizontal
              layout.minimumLineSpacing = 6
              layout.estimatedItemSize = CGSize(width: 94, height: 29)
              layout.sectionInset = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
          }
          showsHorizontalScrollIndicator = false
      }
}

extension Reactive where Base: FormatsCollectionView {
    
    func sections(_ sections: Observable<[FormatsSection]>) -> Disposable {
        let formatCellReuseId = "FormatCell"
        base.register(FormatCell.self, forCellWithReuseIdentifier: formatCellReuseId)
        let dataSource = RxCollectionViewSectionedReloadDataSource<FormatsSection>(configureCell: { (_, collectionVw, indexPath, formatDescription) -> UICollectionViewCell in
            let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: formatCellReuseId, for: indexPath)
            
            print("formatcell : \(cell), \(cell as? FormatCell)")
            
            if let format = cell as? FormatCell {
                format.titleLbl.text = formatDescription
                print("format22222: \(format.titleLbl.text)")
            }
            return cell
        })
        return sections.bind(to: base.rx.items(dataSource: dataSource))
    }
}

