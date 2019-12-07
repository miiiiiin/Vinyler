//
//  SearchViewController.swift
//  Vinyler
//
//  Created by Min on 2019/12/07.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UITableViewController {

    private let backBtn = UIButton.back
    private let inputField = UITextField.standard
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        let header = UIView(forAutoLayout: ())
        [backBtn, inputField].forEach(header.addSubview)
        
        NSLayoutConstraint.activate([
                   header.widthAnchor.constraint(equalToConstant: view.frame.width),
                   backBtn.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 33),
                   backBtn.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 35),
                   backBtn.bottomAnchor.constraint(equalTo: header.bottomAnchor),
                   inputField.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 24),
                   inputField.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
                   inputField.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -22),
                   inputField.heightAnchor.constraint(equalToConstant: 44)
               ])
        
        tableView.tableHeaderView = header
               tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
               
               tableView.tableHeaderView?.layoutIfNeeded()
               tableView.separatorInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
               tableView.separatorColor = .gray
               tableView.rowHeight = 176
               tableView.delegate = nil
               tableView.dataSource = nil
               
               inputField.placeholder = .searchPlaceholder
               
               tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchResultCell")
               
               let discogs = DiscogsAPI()
               
               inputField.rx.controlEvent(.editingDidEndOnExit)
                   .withLatestFrom(inputField.rx.text.orEmpty)
                   .asDriver(onErrorJustReturn: "")
                   .distinctUntilChanged()
                   .flatMapLatest { query -> Driver<[Result]> in
                       if query.isEmpty {
                           return Driver.just([])
                       } else {
                           return discogs.search(query: query)
                               .startWith([])
                               .asDriver(onErrorJustReturn: [])
                       }
                   }.drive(tableView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchCell.self)) { (_, result, cell) in
                       cell.update(with: result)
                   }.disposed(by: disposeBag)
               
               tableView.rx.modelSelected(Result.self).subscribe(onNext: { [weak self] searchResult in
                let loadingViewController = LoadingViewController(resourceUrl: searchResult.resourceUrl)
                   let navigationController = UINavigationController(rootViewController: loadingViewController)
                   navigationController.isNavigationBarHidden = true
                   self?.present(navigationController, animated: true)
               }).disposed(by: disposeBag)
               
               backBtn.rx.tap.subscribe(onNext: { [weak self] in
                   self?.inputField.resignFirstResponder()
                   self?.navigationController?.popViewController(animated: true)
               }).disposed(by: disposeBag)
//            tableView.rx.didScroll.skip(1).subscribe(onNext: { [weak self] in
//                   self?.inputField.resignFirstResponder()
//               }).disposed(by: disposeBag)
               
               inputField.becomeFirstResponder()
        }
    }
