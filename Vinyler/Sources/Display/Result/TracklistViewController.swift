//
//  TracklistViewController.swift
//  Vinyler
//
//  Created by Min on 15/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class TracklistViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: TrackListViewModelType!
    
    let backgroundImageView = UIImageView(forAutoLayout: ())
    let visualView = UIVisualEffectView(forAutoLayout: ())
    var backButton = UIButton.back
    let titleLabel = UILabel.header
    let artistLabel = UILabel.subheader
    let tracklistLabel = UILabel.header2
    let separator = UIView.separator
    let tableView = UITableView(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }
    
    override func loadView() {
        let root = UIView.background
        
        tracklistLabel.text = .tracklist
        separator.backgroundColor = .clear
        
        [backgroundImageView, visualView, tableView].forEach(root.addSubview)
        backgroundImageView.pinToSuperview()
        visualView.pinToSuperview()
        tableView.pinToSuperview()
        
        let header = UIView(forAutoLayout: ())
        
        self.setTextColors(labels: [titleLabel, artistLabel, tracklistLabel])
        
        [backButton, titleLabel, artistLabel, tracklistLabel, separator].forEach(header.addSubview)
        
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalToConstant: root.frame.width),
            backButton.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 33),
            backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 35),
            artistLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            artistLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 44),
            artistLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -33),
            titleLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: artistLabel.trailingAnchor),
            tracklistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tracklistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separator.topAnchor.constraint(equalTo: tracklistLabel.bottomAnchor, constant: 15),
            separator.leadingAnchor.constraint(equalTo: tracklistLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale),
            separator.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -15)
        ])
        
        tableView.tableHeaderView = header
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 70
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        } else {
            tableView.backgroundColor = nil
        }
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.8
        visualView.effect = UIBlurEffect(style: .extraLight)
        
        self.view = root
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        output.trackList
            .bind(to: tableView.rx.items)
            .disposed(by: disposeBag)
        
        output.image
            .drive(backgroundImageView.rx.image)
            .disposed(by: disposeBag)
        
        backButton.rx.action = input.dismissAction
        
        output.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.artist
            .bind(to: artistLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}

extension Reactive where Base: UITableView {
    func items(_ items: Observable<[TrackList]>) -> Disposable {
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
