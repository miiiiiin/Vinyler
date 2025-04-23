//
//  ArtistViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/23/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Toaster

protocol ArtistViewModelInput {
    var dismissAction: CocoaAction { get }
}

protocol ArtistViewModelOutput {
    var artistInfo: Observable<Artist> { get }
    var members: Observable<[ArtistDetail]> { get }
    var profile: Observable<String> { get }
    var image: Driver<UIImage?> { get }
}

protocol ArtistViewModelType {
    var input: ArtistViewModelInput { get }
    var output: ArtistViewModelOutput { get }
}

class ArtistViewModel: ArtistViewModelInput, ArtistViewModelOutput, ArtistViewModelType {
    
    var input: ArtistViewModelInput { return self }
    var output: ArtistViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
        }
    }()
    
    var artistInfo: Observable<Artist>
    var members: Observable<[ArtistDetail]>
    var profile: Observable<String>
    var image: Driver<UIImage?> = Driver.just(nil)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, artistInfo: Artist) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.artistInfo = .just(artistInfo)
        self.members = .just(artistInfo.members)
        self.profile = .just(artistInfo.profilePlaintext)
        self.setImage(images: artistInfo.images)
    }
    
    private func setImage(images: [Image]) {
        self.image = self.images
            .asDriver(onErrorDriveWith: .empty())
            .map { images -> URL? in
                let primaryImage = images.first(where: { $0.type == .primary} )
                let anyImage = images.first
                return URL(string: (primaryImage ?? anyImage)?.resourceUrl ?? "")
            }
            .flatMapLatest { imageUrl -> Driver<UIImage?> in
                guard let url = imageUrl else {
                    return Driver.just(nil)
                }
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
                    .map(UIImage.init)
                    .asDriver(onErrorJustReturn: nil)
            }
    }

}
