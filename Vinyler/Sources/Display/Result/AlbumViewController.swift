//
//  AlbumViewController.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import RxCocoa
import RxSwift
import StoreKit
import UIKit
import SnapKit
import GoogleMobileAds

class AlbumViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: AlbumViewModelType!
    
    private let closeButton = UIButton.close
    private let moreButton = UIButton.more
    private let artistLabel = UILabel.subheader
    private let titleLabel = UILabel.subheader
    private var albumImageView = UIImageView(forAutoLayout: ())
    private let vinylImageView = UIImageView(forAutoLayout: ())
    private let dateLabel = UILabel.bodyLight
    private let formatsCollectionView = FormatsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let disclosureButton = DisclosureButton(forAutoLayout: ())
    private let playerImageView = UIImageView(forAutoLayout: ())
    private let descriptionTitleLabel = UILabel.header2
    private let descriptionLabel = UILabel.body
    private var bannerView: GADBannerView!
    private var likeButton = UIButton.like
    private var releaseInfo: Release!
    private let disposeBag = DisposeBag()
    
    //    init(release: Release) {
    //        super.init(nibName: nil, bundle: nil)
    //        releaseInfo = release
    //        titleLabel.text = release.title
    //        artistLabel.text = release.artistsSort.uppercased()
    //
    //        if let releaseDate = release.releasedFormatted {
    //            dateLabel.text = String(format: .releasedOn, releaseDate)
    //        }
    //
    //        if let video = release.videos {
    //            let videoString = String(format: .watchOnYoutube)
    //            disclosureButton.titleLbl.set(bodyText: videoString, boldPart: videoString, oneLine: true)
    //        } else {
    //            disclosureButton.isHidden = true
    //            let noInfoString = String(format: .noInfoVideo)
    //            disclosureButton.titleLbl.set(bodyText: noInfoString, boldPart: noInfoString, oneLine: true)
    //        }
    //
    //        descriptionTitleLabel.text = .description
    //
    //        if let notes = release.notes {
    //            descriptionLabel.set(bodyText: notes)
    //        }
    //
    //
    //        let imageDriver: Driver<UIImage?>
    //
    //        let primaryImage = release.images.filter { $0.type == .primary }.first
    //        let anyImage = release.images.first
    //        let image = primaryImage ?? anyImage
    //        if let imageUrlString = image?.resourceUrl,
    //           let imageUrl = URL(string: imageUrlString) {
    //            let request = URLRequest(url: imageUrl)
    //            imageDriver = URLSession.shared.rx.data(request: request).map(UIImage.init).asDriver(onErrorJustReturn: nil)
    //        } else {
    //            imageDriver = Driver.just(nil)
    //        }
    //
    //        imageDriver.do(onNext: { [weak self] _ in
    //            self?.vinylImageView.isHidden = false
    //
    //        }).filter { $0 != nil }
    //            .drive(albumImageView.rx.image)
    //            .disposed(by: disposeBag)
    //
    //        closeButton.rx.tap.subscribe(onNext: { [weak self] in
    //            self?.navigationController?.dismiss(animated: true)
    //        }).disposed(by: disposeBag)
    //
    //        moreButton.rx.tap
    //            .map { [ActionSheetOption.artistDetails, .tracklist] }
    //            .flatMap(presentCustomActionSheet)
    //            .subscribe(onNext: { [weak self] option in
    //                switch option {
    //
    //                case .artistDetails:
    //                    let loadingVC = LoadingViewController(artistResourceUrl: release.mainArtistUrl)
    //                    self?.navigationController?.pushViewController(loadingVC, animated: true)
    //                case .tracklist:
    //                    let tracklistVC = TracklistViewController(release: release, image: imageDriver)
    //                    self?.navigationController?.pushViewController(tracklistVC, animated: true)
    //                }
    //            }).disposed(by: disposeBag)
    //
    //        let formatDescription = release.formats.reduce([]) { result, format -> [String] in
    //            var array = result
    //            array.append(contentsOf: format.descriptions)
    //            return array
    //        }
    //
    //        Observable.just([FormatsSection(items: formatDescription)]).bind(to: formatsCollectionView.rx.sections).disposed(by: disposeBag)
    //
    //    }
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setTextColors(labels: [UILabel]) {
        labels.forEach { label in
            label.textColor = style.Colors.tint
        }
    }
    
    override func loadView() {
        let root = UIScrollView(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            root.backgroundColor = .systemBackground
        } else {
            root.backgroundColor = .white
        }
        let contentView = UIView(forAutoLayout: ())
        root.addSubview(contentView)
        self.modalPresentationStyle = .fullScreen
        
        self.setTextColors(labels: [artistLabel, titleLabel, descriptionTitleLabel, descriptionLabel])
        
        descriptionTitleLabel.text = .description
        
        let albumWithVinyl = UIView(forAutoLayout: ())
        
        [vinylImageView, albumImageView].forEach(albumWithVinyl.addSubview)
        
        
        let adSize = GADAdSize(size: CGSize(width: UIScreen.main.bounds.width, height: 44), flags: 0)
        bannerView = GADBannerView(adSize: adSize)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = Constants.GoogleAds.adKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: albumWithVinyl.leadingAnchor),
            albumImageView.topAnchor.constraint(equalTo: albumWithVinyl.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: albumWithVinyl.bottomAnchor),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor),
            vinylImageView.trailingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 43),
            vinylImageView.topAnchor.constraint(equalTo: albumImageView.topAnchor),
            vinylImageView.trailingAnchor.constraint(equalTo: albumWithVinyl.trailingAnchor),
            vinylImageView.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor),
            vinylImageView.widthAnchor.constraint(equalTo: albumImageView.widthAnchor)
        ])
        
        closeButton.tintColor = style.Colors.tint
        
        [closeButton, moreButton, artistLabel, titleLabel, albumWithVinyl, dateLabel, formatsCollectionView, likeButton, disclosureButton, playerImageView, descriptionTitleLabel, descriptionLabel, bannerView].forEach(contentView.addSubview)
        
        contentView.pinToSuperview()
        
        vinylImageView.image = #imageLiteral(resourceName: "vinyl")
        vinylImageView.isHidden = true
        
        albumImageView.image = #imageLiteral(resourceName: "placeholder")
        albumImageView.contentMode = .scaleAspectFill
        
        playerImageView.image = #imageLiteral(resourceName: "icons8-play-button-48")
        
        let noInfoString = String(format: .noInfoVideo)
        disclosureButton.titleLbl.set(bodyText: noInfoString, boldPart: noInfoString, oneLine: true)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: root.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 33),
            closeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
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
            dateLabel.topAnchor.constraint(equalTo: albumWithVinyl.bottomAnchor, constant: 33),
            dateLabel.leadingAnchor.constraint(equalTo: albumWithVinyl.leadingAnchor),
            formatsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            formatsCollectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 33),
            formatsCollectionView.trailingAnchor.constraint(equalTo: disclosureButton.trailingAnchor),
            formatsCollectionView.heightAnchor.constraint(equalToConstant: 29),
            disclosureButton.topAnchor.constraint(equalTo: formatsCollectionView.bottomAnchor, constant: 11),
            disclosureButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            disclosureButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44),
            playerImageView.topAnchor.constraint(equalTo: disclosureButton.topAnchor, constant: 5),
            playerImageView.leftAnchor.constraint(equalTo: disclosureButton.rightAnchor, constant: -44),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: disclosureButton.leadingAnchor),
            descriptionTitleLabel.topAnchor.constraint(equalTo: disclosureButton.bottomAnchor, constant: 33),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 22),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
            
            bannerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        //        bannerView.snp.makeConstraints { make in
        //            make.top.equalTo(descriptionLabel.snp.bottom)
        //            make.leading.equalTo(contentView.snp.leading)
        //            make.trailing.equalTo(contentView.snp.trailing)
        //            make.bottom.equalTo(contentView.snp.bottom)
        //        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalTo(disclosureButton.snp.trailing)
        }
        
        
        vinylImageView.transform = CGAffineTransform(translationX: -44, y: 0).rotated(by: -CGFloat.pi / 2)
        
        self.view = root
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        disclosureButton.rx.tap
            .withLatestFrom(output.releaseInfo)
            .subscribe(onNext: { [weak self] release in
                if let url = URL(string: "\(release.videos?.first?.uri ?? "")") {
                    UIApplication.shared.open(url, options: [:])
                }
            })
            .disposed(by: disposeBag)
        
        likeButton.rx.tap
            .observe(on: MainScheduler.instance)
            .withLatestFrom(Observable.just(releaseInfo))
            .unwrap()
            .bind(to: input.likeAction.inputs)
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .map{ String(format: .releasedOn, $0.releasedFormatted ?? "") }
            .observe(on: MainScheduler.instance)
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .map{ $0.artistsSort.uppercased() }
            .observe(on: MainScheduler.instance)
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .map{ $0.title }
            .observe(on: MainScheduler.instance)
            .bind(to: artistLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .map { $0.videos }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] str in
                if let video = str {
                    let videoString = String(format: .watchOnYoutube)
                    self?.disclosureButton.titleLbl.set(bodyText: videoString, boldPart: videoString, oneLine: true)
                    
                } else {
                    self?.disclosureButton.isHidden = true
                    let noInfoString = String(format: .noInfoVideo)
                    self?.disclosureButton.titleLbl.set(bodyText: noInfoString, boldPart: noInfoString, oneLine: true)
                }
            })
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .observe(on: MainScheduler.instance)
            .map{ $0.notes }
            .unwrap()
            .subscribe(onNext: { [weak self] notes in
                self?.descriptionLabel.set(bodyText: notes)
            })
            .disposed(by: disposeBag)
        
        output.albumImage
            .drive(albumImageView.rx.image)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(to: input.dismissAction.inputs)
            .disposed(by: disposeBag)
        
        //        moreButton.rx.tap
        //            .map { [ActionSheetOption.artistDetails, .tracklist] }
        //            .flatMap(presentCustomActionSheet)
        //            .subscribe(onNext: { [weak self] option in
        //                switch option {
        //
        //                case .artistDetails:
        //                    let loadingVC = LoadingViewController(artistResourceUrl: release.mainArtistUrl)
        //                    self?.navigationController?.pushViewController(loadingVC, animated: true)
        //                case .tracklist:
        //                    let tracklistVC = TracklistViewController(release: release, image: imageDriver)
        //                    self?.navigationController?.pushViewController(tracklistVC, animated: true)
        //                }
        //            }).disposed(by: disposeBag)
        
        output.releaseInfo
            .observe(on: MainScheduler.instance)
            .map { $0.formats.reduce([]) { result, format -> [String] in
                var array = result
                array.append(contentsOf: format.descriptions)
                return array
            }}
            .map {[FormatsSection(items: $0)]}
            .bind(to: formatsCollectionView.rx.sections)
            .disposed(by: disposeBag)
    }
}

extension AlbumViewController: GADBannerViewDelegate {
    // MARK: - Delegate
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 0.1) {
            bannerView.alpha = 1
        }
    }
}
