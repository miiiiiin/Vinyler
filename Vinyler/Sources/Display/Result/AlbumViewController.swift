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
    
    private let reviewStackView = UIStackView(forAutoLayout: ())
    private let reviewView = UIView.review
    lazy var tableView = UITableView(forAutoLayout: ())
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
        contentView.pinToSuperview()
        
        let albumWithVinyl = UIView(forAutoLayout: ())
        
        [vinylImageView, albumImageView].forEach(albumWithVinyl.addSubview)
        
        setUpBanner()
        setUpLayout()
        setUpTableView()
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(root.snp.width)
        }
        
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
        
        [closeButton, moreButton, artistLabel, titleLabel, albumWithVinyl, dateLabel, likeButton, formatsCollectionView, disclosureButton, playerImageView, reviewStackView, descriptionTitleLabel, descriptionLabel, bannerView].forEach(contentView.addSubview)
        
        [reviewView, tableView].forEach(reviewStackView.addArrangedSubview)
        
        setUpReviewView(contentView: contentView)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin).offset(33)
            make.leading.equalToSuperview().offset(33)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-33)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(artistLabel.snp.bottom).offset(6)
            make.leading.equalTo(artistLabel.snp.leading)
            make.trailing.equalTo(artistLabel.snp.trailing)
        }
        
        albumWithVinyl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(albumWithVinyl.snp.bottom).offset(33)
            make.leading.equalTo(albumWithVinyl.snp.leading)
        }
        
        formatsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(33)
            make.leading.equalToSuperview()
            make.trailing.equalTo(disclosureButton.snp.trailing)
            make.height.equalTo(29)
        }
        
        disclosureButton.snp.makeConstraints { make in
            make.top.equalTo(formatsCollectionView.snp.bottom).offset(11)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-44)
        }
        
        playerImageView.snp.makeConstraints { make in
            make.top.equalTo(disclosureButton.snp.top).offset(5)
            make.left.equalTo(disclosureButton.snp.right).offset(-44)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewStackView.snp.bottom).offset(10)
            make.leading.equalTo(disclosureButton.snp.leading)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(22)
            make.leading.equalTo(descriptionTitleLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-33)
            make.bottom.equalToSuperview().offset(-44)
        }
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalTo(disclosureButton.snp.trailing)
        }
        
        self.view = root
    }
    
    func setUpReviewView(contentView: UIView) {
        reviewStackView.snp.makeConstraints { make in
            make.top.equalTo(disclosureButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        reviewView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(105)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setUpLayout() {
        reviewStackView.alignment = .fill
        reviewStackView.axis = .vertical
        self.setTextColors(labels: [artistLabel, titleLabel, descriptionTitleLabel, descriptionLabel])
        
        descriptionTitleLabel.text = .description
        closeButton.tintColor = style.Colors.tint
        
        vinylImageView.image = #imageLiteral(resourceName: "vinyl")
        vinylImageView.isHidden = true
        albumImageView.image = #imageLiteral(resourceName: "placeholder")
        albumImageView.contentMode = .scaleAspectFill
        playerImageView.image = #imageLiteral(resourceName: "icons8-play-button-48")
        
        vinylImageView.transform = CGAffineTransform(translationX: -44, y: 0).rotated(by: -CGFloat.pi / 2)
        
        let noInfoString = String(format: .noInfoVideo)
        disclosureButton.titleLbl.set(bodyText: noInfoString, boldPart: noInfoString, oneLine: true)
    }
    
    func setUpBanner() {
        let adSize = GADAdSize(size: CGSize(width: UIScreen.main.bounds.width, height: 44), flags: 0)
        bannerView = GADBannerView(adSize: adSize)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = Constants.GoogleAds.adKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func setUpTableView() {
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .veryLightPink
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        tableView.delegate = nil
        tableView.dataSource = nil
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
            .withLatestFrom(output.releaseInfo)
            .flatMapLatest { release -> Observable<Bool> in
                return input.likeAction.execute(release)
            }
            .bind(to: output.isLike)
            .disposed(by: disposeBag)
        
        output.isLike
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLiked in
                let image: UIImage = isLiked ? .fullHeart! : .emptyHeart!
                self?.likeButton.setImage(image, for: .normal)
            })
            .disposed(by: disposeBag)
        
        output.releaseInfo
            .map { $0.id }
            .flatMapLatest { discogsId -> Observable<Bool> in
                return input.getLikeStatusAction.execute(discogsId)
            }
            .bind(to: output.isLike)
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
                }}).disposed(by: disposeBag)
        
        output.releaseInfo
            .observe(on: MainScheduler.instance)
            .map{ $0.notes }
            .unwrap()
            .subscribe(onNext: { [weak self] notes in
                self?.descriptionLabel.set(bodyText: notes)
            }).disposed(by: disposeBag)
        
        output.albumImage
            .drive(albumImageView.rx.image)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(to: input.dismissAction.inputs)
            .disposed(by: disposeBag)
        
        moreButton.rx.tap
            .map { [ActionSheetOption.artistDetails, .tracklist] }
            .flatMapLatest { [weak self] options -> Observable<(ActionSheetOption, Release)> in
                guard let self = self else { return .empty() }
                return self.presentCustomActionSheet(with: options)
                    .withLatestFrom(output.releaseInfo) { selectedOption, releaseInfo in
                        (selectedOption, releaseInfo)
                    }
            }
            .subscribe(onNext: { (option, release) in
                switch option {
                case .artistDetails:
                    input.loadingAction.execute(release.mainArtistUrl)
                case .tracklist:
                    input.tracklistAction.execute(release)
                }
            })
            .disposed(by: disposeBag)
        
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

//extension Reactive where Base: UITableView {
//    func items(_ items: Observable<[VinylerRelease]>) -> Disposable {
//        let cellId = "ReviewCell"
//
//        base.register(ReviewCell.self, forCellReuseIdentifier: cellId)
//
//        return items.bind(to: base.rx.items(cellIdentifier: cellId)) { _, item, cell in
//
//            if let cell = cell as? ReviewCell {
//                cell.update(with: item)
//            }
//        }
//    }
//}
