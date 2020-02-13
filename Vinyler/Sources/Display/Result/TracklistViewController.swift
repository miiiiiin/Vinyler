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

class TracklistViewController: UIViewController {
    
    let backgroundImageView = UIImageView(forAutoLayout: ())
    let visualView = UIVisualEffectView(forAutoLayout: ())
    let backButton = UIButton.back
    let titleLabel = UILabel.header
    let artistLabel = UILabel.subheader
    let tracklistLabel = UILabel.header2
    let separator = UIView.separator
    let tableView = UITableView(forAutoLayout: ())
    
    private let disposeBag = DisposeBag()
    
    init(release: Release, image: Driver<UIImage?>) {
        super.init(nibName: nil, bundle: nil)
        
        Observable.just(release.tracklist).bind(to: tableView.rx.items).disposed(by: disposeBag)
        
        image.drive(backgroundImageView.rx.image).disposed(by: disposeBag)
        
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            
        }).disposed(by: disposeBag)
        
        titleLabel.text = release.title
        artistLabel.text = release.artistsSort.uppercased()
        tracklistLabel.text = .tracklist
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .black
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    override func loadView() {
        let root = UIView.background
        
        [backgroundImageView, visualView, tableView].forEach(root.addSubview)
        backgroundImageView.pinToSuperview()
        visualView.pinToSuperview()
        tableView.pinToSuperview()
        
        let header = UIView(forAutoLayout: ())
        
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
            tracklistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 33),
            tracklistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separator.topAnchor.constraint(equalTo: tracklistLabel.bottomAnchor, constant: 15),
            separator.leadingAnchor.constraint(equalTo: tracklistLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1/UIScreen.main.scale),
            separator.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ])
        
        tableView.tableHeaderView = header
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 70
        tableView.backgroundColor = nil
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.9
        visualView.effect = UIBlurEffect(style: .extraLight)
        
        self.view = root
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
