//
//  ReviewListViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 6/12/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action

class ReviewListViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: ReviewListViewModelType!
    
    private let tableView = UITableView(forAutoLayout: ())
    private let closeButton = UIButton.close
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }

    override func loadView() {
        let root = UIView.background
        if #available(iOS 13.0, *) {
            root.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
            tableView.backgroundColor = .systemBackground
        } else {
            root.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            tableView.backgroundColor = .white
        }
        
        [tableView].forEach(root.addSubview)
        tableView.pinToSuperview()
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
     
        let header = UIView(forAutoLayout: ())
        tableView.tableHeaderView = header
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 70
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(33)
            make.leading.equalToSuperview().offset(33)
        }
        
        self.view = root
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        closeButton.rx.action = input.dismissAction
    }
    
}


extension Reactive where Base: UITableView {
    func items(_ items: Observable<[TrackList]>) -> Disposable {
        let cellId = "ReviewCell"
        
        base.register(ReviewCell.self, forCellReuseIdentifier: cellId)
        
        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, track, cell in
            
            if let cell = cell as? ReviewCell {
                // todo
            }
        }
    }
}
