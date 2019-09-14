//
//  AlbumViewController.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import StoreKit
import UIKit

class AlbumViewController: UIViewController {

    private let closeButton = UIButton.close
    private let moreButton = UIButton.more
    private let artistLabel = UILabel.subheader
    private let titleLabel = UILabel.subheader
    private var albumImageView = UIImageView(forAutoLayout: ())
    private let vinylImageView = UIImageView(forAutoLayout: ())
    private let dateLabel = UILabel.bodyLight
    private let formatsCollectionView = FormatsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let descriptionTitleLabel = UILabel.header2
    private let descriptionLabel = UILabel.body
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(release: Release) {
        super.init(nibName: nil, bundle: nil)

        titleLabel.text = release.title
        artistLabel.text = release.artistsSort.uppercased()

        if let releaseDate = release.releasedFormatted {
            dateLabel.text = String(format: .releasedOn, releaseDate)
        }

        if let price = release.lowestPrice {
            let priceString = "$ \(price)"

        } else {
            print("not available")
        }

        descriptionTitleLabel.text = .description

        if let notes = release.notes {
            descriptionLabel.set(bodyText: notes)
        }

        vinylImageView.image = #imageLiteral(resourceName: "vinyl")
        vinylImageView.isHidden = true

        albumImageView.image = #imageLiteral(resourceName: "placeholder")
        albumImageView.contentMode = .scaleAspectFill

        let imageDriver: Driver<UIImage?>

        let primaryImage = release.images.filter { $0.type == .primary }.first
        let anyImage = release.images.first
        let image = primaryImage ?? anyImage
        if let imageUrlString = image?.resourceUrl,
            let imageUrl = URL(string: imageUrlString) {
            let request = URLRequest(url: imageUrl)
            imageDriver = URLSession.shared.rx.data(request: request).map(UIImage.init).asDriver(onErrorJustReturn: nil)
        } else {
            imageDriver = Driver.just(nil)
        }

        imageDriver.do(onNext: { [weak self] _ in
            self?.vinylImageView.isHidden = false

        }).filter { $0 != nil }
        .drive(albumImageView.rx.image)
        .disposed(by: disposeBag)

        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.dismiss(animated: true)
        }).disposed(by: disposeBag)

//        moreButton.rx.tap
//            .map { [ActionSheetOption.artistDetails, .tracklist] }
//            .flatMap(presentCustomActionSheet)
//            .subscribe(onNext: { [weak self] option in
//                switch option {
//                case .artistDetails:
//                    let loadingViewController = LoadingViewController(artistResourceUrl: release.mainArtistResourceUrl)
//                    self?.navigationController?.pushViewController(loadingViewController, animated: true)
//                case.tracklist:
//                    let tracklistViewController = TracklistViewController(release: release, image: imageDriver)
//                    self?.navigationController?.pushViewController(tracklistViewController, animated: true)
//                }
//            })
//            .disposed(by: bag)
        
        moreButton.rx.tap
            .map { [ActionSheetOption.artistDetails, .tracklist] }
            .flatMap(presentCustomActionSheet)
            .subscribe(onNext: { [weak self] option in
                switch option {
                    
                case .artistDetails:
                    let loadingVC = LoadingViewController(barcode: "1111")
                    self?.navigationController?.pushViewController(loadingVC, animated: true)
                case .tracklist:
                    return
//                    let tracklistVC =
                    
                    
                }
            }).disposed(by: disposeBag)

        let formatDescription = release.formats.reduce([]) { result, format -> [String] in

            var array = result
            array.append(contentsOf: format.descriptions)
            return array
        }

//        Observable.just([FormatsSection(items: formatDescriptions)]).bind(to: formatsCollectionView.rx.sections).disposed(by: bag)

        vinylImageView.transform = CGAffineTransform(translationX: -44, y: 0).rotated(by: -CGFloat.pi / 2)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.vinylImageView.transform = .identity
        }) { completed in
            if completed {
                SKStoreReviewController.requestReview()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func loadView() {
        let root = UIScrollView(frame: UIScreen.main.bounds)
        root.backgroundColor = .white
        let contentView = UIView(forAutoLayout: ())
        root.addSubview(contentView)

        let albumWithVinyl = UIView(forAutoLayout: ())

        [vinylImageView, albumImageView].forEach(albumWithVinyl.addSubview)

        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: albumWithVinyl.leadingAnchor),
            albumImageView.topAnchor.constraint(equalTo: albumWithVinyl.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: albumWithVinyl.bottomAnchor),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor),
            vinylImageView.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 43),
            vinylImageView.topAnchor.constraint(equalTo: albumImageView.topAnchor),
            vinylImageView.trailingAnchor.constraint(equalTo: albumWithVinyl.trailingAnchor),
            vinylImageView.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor),
            vinylImageView.widthAnchor.constraint(equalTo: vinylImageView.heightAnchor)
        ])

        [closeButton, moreButton, artistLabel, titleLabel, albumWithVinyl, dateLabel, descriptionTitleLabel, descriptionLabel].forEach(contentView.addSubview)
        contentView.pinToSuperview()

        NSLayoutConstraint.activate([

            contentView.widthAnchor.constraint(equalTo: root.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            moreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            artistLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 33),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            titleLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: artistLabel.trailingAnchor),
            albumWithVinyl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44),
            albumWithVinyl.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            albumWithVinyl.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            albumWithVinyl.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),

            dateLabel.topAnchor.constraint(equalTo: albumWithVinyl.bottomAnchor, constant: 50),
            dateLabel.leadingAnchor.constraint(equalTo: albumWithVinyl.leadingAnchor),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descriptionTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 33),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 22),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44)

        ])

        self.view = root
    }
}