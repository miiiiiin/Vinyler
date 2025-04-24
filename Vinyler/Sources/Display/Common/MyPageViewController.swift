//
//  MyPageViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class MyPageViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: MyPageViewModelType!
    
    let tableView = UITableView(forAutoLayout: ())
    let titleLabel = UILabel.header
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
    }
    
    override func loadView() {
        let root = UIView()
        
        [tableView].forEach(root.addSubview(_:))
        
        tableView.pinToSuperview()
        
        let header = UIView(forAutoLayout: ())
        
        [titleLabel].forEach(header.addSubview)
        
        header.snp.makeConstraints { make in
            make.width.equalTo(root.frame.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.top).offset(35)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        tableView.tableHeaderView = header
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 70
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        } else {
            root.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
        
        self.view = root
        
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.menuItems
            .bind(to: tableView.rx.items)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UITableView {
    func items(_ items: Observable<[Menu]>) -> Disposable {
        let cellId = "menuCell"
        
        base.register(MenuCell.self, forCellReuseIdentifier: cellId)
        
        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, item, cell in
            
            if let cell = cell as? MenuCell {
                cell.titleLabel.text = item.title
                cell.imgView.image = item.icon
            }
        }
    }
}
