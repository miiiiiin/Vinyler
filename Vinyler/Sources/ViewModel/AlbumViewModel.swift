//
//  AlbumViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Toaster

protocol AlbumViewModelInput {
    var likeAction: Action<Release, Bool> { get }
    var loadingAction: Action<String, Void> { get }
    var dismissAction: CocoaAction { get }
    var tracklistAction: Action<Release, Void> { get }
}

protocol AlbumViewModelOutput {
    var releaseInfo: Observable<Release> { get }
    var isLike: PublishRelay<Bool> { get }
    var albumImage: Driver<UIImage?> { get }
}

protocol AlbumViewModelType {
    var input: AlbumViewModelInput { get }
    var output: AlbumViewModelOutput { get }
}

class AlbumViewModel: AlbumViewModelInput, AlbumViewModelOutput, AlbumViewModelType {

    
    var input: AlbumViewModelInput { return self }
    var output: AlbumViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var likeAction: Action<Release, Bool> = {
        Action<Release, Bool> { [unowned self] input in
            
            let request = LikeRequest.transform(release: input)
            return self.useCase.execute(request: request)
                .flatMap { result -> Observable<Bool> in
                    switch result {
                    case let .success(response):
                        
                        debugPrint("like action result: \(response)")
//                        let isLiked = response.isLiking == 1 ? true : false
                        return .just(response.isLiking)
                        
                    case let .failure(error):
                        let errorResponse = error.errorDescription
                        Toast(text: errorResponse).show()
                        return .empty()
                        
                    }
                }
        }
    }()
    
    lazy var loadingAction: Action<String, Void> = {
        Action<String, Void> { [unowned self] input in
            let viewModel = LoadingViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, barcode: nil, resourceUrl: nil, artistResourceUrl: input)
            return self.sceneCoordinator.transition(to: Scene.loading(viewModel))
        }
    }()
    
    lazy var tracklistAction: Action<Release, Void> = {
        Action<Release, Void> { [unowned self] input in
            let viewModel = TrackListViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, release: input, image: self.albumImage)
            return self.sceneCoordinator.transition(to: Scene.tracklist(viewModel))
        }
    }()
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismissAll(animated: true).asObservable().map { _ in }
        }
    }()
    
    
    var releaseInfo: Observable<Release>
    var isLike = PublishRelay<Bool>()
    var albumImage: Driver<UIImage?> = Driver.just(nil)
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, release: Release) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.releaseInfo = Observable.just(release)
        self.setAlbumImage()
    }
    
    private func setAlbumImage() {
        self.albumImage = self.releaseInfo
            .asDriver(onErrorDriveWith: .empty())
            .map { release -> URL? in
                let primaryImage = release.images.first(where: { $0.type == .primary })
                let anyImage = release.images.first
                return URL(string: (primaryImage ?? anyImage)?.uri ?? "")
            }
            .flatMapLatest { imageURL -> Driver<UIImage?> in
                guard let url = imageURL else {
                    return Driver.just(nil)
                }
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
                    .map(UIImage.init)
                    .asDriver(onErrorJustReturn: nil)
            }
    }
}
