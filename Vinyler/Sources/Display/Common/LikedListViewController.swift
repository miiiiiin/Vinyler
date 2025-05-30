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

class LikedListViewController: UITableViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: LikedListViewModelType!
    
    var backButton = UIButton.back
    let titleLabel = UILabel.header
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    func setUpLayout() {
        let root = UIView.background
        
        titleLabel.text = "좋아요 표시한 음반"
        
        let header = UIView(forAutoLayout: ())
        header.backgroundColor = .red
        
        [backButton, titleLabel].forEach(header.addSubview)
        
//        header.snp.makeConstraints { make in
//            make.width.equalTo(root.frame.width)
//            make.height.equalTo(70)
//        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(header.safeAreaLayoutGuide.snp.top).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
        
        tableView.tableHeaderView = header
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        tableView.delegate = nil
        tableView.dataSource = nil
        
        tableView.tableHeaderView?.layoutIfNeeded()
        
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
        
//        output.likedAlbums
//            .bind(to: tableView.rx.items)
//            .disposed(by: disposeBag)
        
        backButton.rx.action = input.backAction
    }
}
//
//
//extension Reactive where Base: UITableView {
//    func items(_ items: Observable<[VinylerRelease]>) -> Disposable {
//        let cellId = "likeCell"
//        
//        base.register(LikeCell.self, forCellReuseIdentifier: cellId)
//        
//        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, item, cell in
//            
//            if let cell = cell as? LikeCell {
////                cell.titleLabel.text = item.title
////                cell.albumImageView.image = item.
////                cell.artistLabel.text = item.artistsSort.uppercased()
//            }
//        }
//    }
//}
//
