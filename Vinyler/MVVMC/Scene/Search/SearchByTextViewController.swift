//
//  SearchByTextViewController.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/25.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class SearchByTextViewController: UITableViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: SearchByTextViewModelType!

    // MARK: - UI Properties
    
    private let backBtn = UIButton.back
    private let inputField = UITextField.standard
    
    // MARK: - Private

    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<SearchResultSection> { dataSource, tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        debugPrint("cell check: \(item.title)")
        cell.update(with: item)
        return cell
    }
    
    func setUpUI() {
        let header = UIView(forAutoLayout: ())
        [backBtn, inputField].forEach(header.addSubview)
        
        tableView.do {
            $0.tableHeaderView = header
            $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            $0.tableHeaderView?.layoutIfNeeded()
            $0.separatorInset = .zero
            $0.layoutMargins = .zero
            $0.separatorStyle = .singleLine
            $0.separatorColor = .veryLightPink
            $0.rowHeight = 176
            $0.delegate = nil
            $0.dataSource = nil
            $0.register(SearchCell.classForCoder(), forCellReuseIdentifier: "SearchCell")
        }
        
        inputField.placeholder = .searchPlaceholder
        
        header.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(header.snp.topMargin).offset(33)
            make.leading.equalTo(header.snp.leading).offset(24)
            make.bottom.equalTo(header.snp.bottom)
        }
        
        inputField.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.leading.equalTo(backBtn.snp.trailing).offset(24)
            make.trailing.equalTo(header.snp.trailing).offset(-24)
            make.height.equalTo(44)
        }
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.resultSection
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
}
