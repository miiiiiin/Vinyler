//
//  CustomActionSheetViewController.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CustomActionSheetViewController: UIViewController {
    
    fileprivate let tableView = DynamicTableView(forAutoLayout: ())
    fileprivate let header = CustomActionSheetHeader(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    init(options: [ActionSheetOption]) {
        super.init(nibName: nil, bundle: nil)
        
        Observable.just(options).bind(to: tableView.rx.items).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        header.layoutIfNeeded()
        tableView.tableHeaderView = header
    }
    
    override func loadView() {
        let root = UIView(frame: UIScreen.main.bounds)
        
        root.addSubview(tableView)
        tableView.tableHeaderView = header
        
        self.view = root
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            header.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        ])
        
        root.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 70
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.separatorColor = .lightGray
    }
}

extension Reactive where Base: UITableView {
    
    func items(_ items: Observable<[ActionSheetOption]>) -> Disposable {
        let cellId = "ActionSheetCell"
        base.register(CustomActionSheetCell.self, forCellReuseIdentifier: cellId)
        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { (_, option, cell) in
            if let cell = cell as? CustomActionSheetCell {
                cell.update(option: option)
            }
        }
    }
}

extension UIViewController {
    
    //MARK: - Presenting Custom Action Sheet shows artist details and tracklist
    
    func presentCustomActionSheet(with options: [ActionSheetOption]) -> Observable<ActionSheetOption> {
        
        let actionSheet = CustomActionSheetViewController(options: options)
        actionSheet.modalPresentationStyle = .pageSheet //.overCurrentContext
        present(actionSheet, animated: true, completion: nil)
        
        let close: Observable<ActionSheetOption?> = actionSheet.header.closeButton.rx.tap.map { nil }
        let selected: Observable<ActionSheetOption?> = actionSheet.tableView.rx.modelSelected(ActionSheetOption.self).map { $0 }
        
        return Observable.merge(close, selected)
            .do(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            }).filterNil()
        }
}
