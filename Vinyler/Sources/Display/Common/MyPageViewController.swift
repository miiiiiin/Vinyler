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
    var backButton = UIButton.back
    let tableView = UITableView(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    override func loadView() {
        let root = UIView.background
        let contentView = UIView(forAutoLayout: ())
        if #available(iOS 13.0, *) {
            root.backgroundColor = .systemBackground
        } else {
            root.backgroundColor = .white
        }
        
        [contentView].forEach(root.addSubview(_:))
        [tableView].forEach(contentView.addSubview(_:))
        
        contentView.pinToSuperview()
        tableView.pinToSuperview()
        
        let header = UIView(forAutoLayout: ())

        [backButton].forEach(header.addSubview)
        
        header.snp.makeConstraints { make in
            make.width.equalTo(root.frame.width)
            make.height.equalTo(70)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(header.safeAreaLayoutGuide.snp.top).offset(33)
            make.leading.equalToSuperview().offset(24)
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
        
        tableView.rx.modelSelected(Menu.self)
            .map { $0.id }
            .bind(to: input.nextAction.inputs)
            .disposed(by: disposeBag)
        
        backButton.rx.action = input.backAction
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
