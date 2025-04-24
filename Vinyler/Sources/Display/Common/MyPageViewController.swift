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
        tableView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        
        self.view = root
        
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
    }
}

extension Reactive where Base: UITableView {
    func items(_ items: Observable<[Menu]>) -> Disposable {
        let cellId = "trackCell"
        
        base.register(TrackCell.self, forCellReuseIdentifier: cellId)
        
        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, track, cell in
            
            if let cell = cell as? TrackCell {
                cell.positionLabel.text = track.position
                cell.titleLabel.text = track.title
                cell.durationLabel.text = track.duration
            }
        }
    }
}
