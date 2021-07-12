//
//  SettingsViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/12.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias SettingsSection = Section<SettingsCellType>

class SettingsViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = .settings
        navigationItem.largeTitleDisplayMode = .always
//        navigationItem.backBarButtonItem = .empty
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.backgroundColor = .gray
        tableView.rowHeight = 57
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        tableView.separatorColor = .white
        tableView.sectionHeaderHeight = 33
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 4 * 24))
        tableView.tableHeaderView = headerView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        
        configureDataSource()
        
    }
    
    func configureDataSource() {
     
        let dataSource = RxTableViewSectionedReloadDataSource<SettingsSection> { (_, tv, indexPath, cellType) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
            
            cell.textLabel?.text = cellType.title
            cell.textLabel?.font = .body
            cell.textLabel?.textColor = cellType == .version ? .gray : .dark
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            
            if cellType != .version {
                cell.accessoryType = .disclosureIndicator
            }
            
            return cell
        }
        
        
//        Observable.just([
//            SettingsSection(items: [.general, .instructions, .privacy], title: .about),
//            SettingsSection(items: [.rate, .share], title: .enjoyUsing),
//            SettingsSection(items: [.credits, .version], title: .other)
//        ]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
        Observable.just([
            SettingsSection(items: [.general, .instructions, .privacy], title: "about")
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
    }
}
