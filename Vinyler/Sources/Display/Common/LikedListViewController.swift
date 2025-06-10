//
//  LikedListViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class LikedListViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: LikedListViewModelType!
    
    var backButton = UIButton.back
    let titleLabel = UILabel.header
    let searchIconView = UIImageView(forAutoLayout: ())

    lazy var tableView = UITableView(forAutoLayout: ())
    private let searchFieldContainer = UIView.background
    private let inputField = UITextField.empty
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }
    
    func setUpLayout() {
        let root = UIView.background
        
        self.setTextColors(labels: [titleLabel])
        
        [tableView].forEach(root.addSubview)
        tableView.register(LikeCell.self, forCellReuseIdentifier: "LikeCell")
        
        titleLabel.text = .likedListTitle
        
        tableView.pinToSuperview()
        let header = UIView(forAutoLayout: ())
        
        [backButton, titleLabel, searchFieldContainer].forEach(header.addSubview)
        
        [inputField, searchIconView].forEach(searchFieldContainer.addSubview)
        
        searchFieldContainer.layer.cornerRadius = 10
        searchFieldContainer.layer.borderWidth = 1
        searchFieldContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        header.snp.makeConstraints { make in
            make.width.equalTo(root.frame.width)
            make.height.equalTo(220)
        }
        
        header.layoutIfNeeded()
        header.frame.size.height = 220
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(header.safeAreaLayoutGuide.snp.top).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
        
        searchFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        
        inputField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-11)
            make.centerY.equalToSuperview()
        }
        
        searchIconView.snp.makeConstraints { make in
            make.trailing.equalTo(inputField.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        searchIconView.image = #imageLiteral(resourceName: "search")
        tableView.tableHeaderView = header
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        tableView.delegate = nil
        tableView.dataSource = nil
        inputField.placeholder = .searchLikedPlaceholder
        
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
        
        output.likedAlbums
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items)
            .disposed(by: disposeBag)
        
        backButton.rx.action = input.backAction
    }
}


extension Reactive where Base: UITableView {
    func items(_ items: Observable<[VinylerRelease]>) -> Disposable {
        let cellId = "LikeCell"

        base.register(LikeCell.self, forCellReuseIdentifier: cellId)

        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, item, cell in

            if let cell = cell as? LikeCell {
                cell.update(with: item)
            }
        }
    }
}

