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
    
    let backButton = UIButton.back
    let titleLabel = UILabel.header
    let tableView = UITableView(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    override func loadView() {
        let root = UIView.background
        
        [tableView].forEach(root.addSubview)
        tableView.pinToSuperview()
        
        let header = UIView(forAutoLayout: ())
        
        [backButton, titleLabel].forEach(header.addSubview)
        
        header.snp.makeConstraints { make in
            make.width.equalTo(root.frame.width)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(header.safeAreaLayoutGuide.snp.top).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(33)
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
        
        output.likedAlbums
            .bind(to: tableView.rx.items)
            .disposed(by: disposeBag)
        
    }
}


extension Reactive where Base: UITableView {
    func items(_ items: Observable<[Release]>) -> Disposable {
        let cellId = "likeCell"
        
        base.register(LikeCell.self, forCellReuseIdentifier: cellId)
        
        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, item, cell in
            
            if let cell = cell as? LikeCell {
                cell.titleLabel.text = item.title
//                cell.albumImageView.image = item.
                cell.artistLabel.text = item.artistsSort.uppercased()
            }
        }
    }
}

