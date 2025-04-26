//
//  TrackListViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/24/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

protocol TrackListViewModelInput {
    var dismissAction: CocoaAction { get }
}

protocol TrackListViewModelOutput {
    var trackList: Observable<[TrackList]> { get }
    var title: Observable<String> { get }
    var artist: Observable<String> { get }
    var image: Driver<UIImage?> { get }
}

protocol TrackListViewModelType {
    var input: TrackListViewModelInput { get }
    var output: TrackListViewModelOutput { get }
}

class TrackListViewModel: TrackListViewModelInput, TrackListViewModelOutput, TrackListViewModelType {
    
    var input: TrackListViewModelInput { return self }
    var output: TrackListViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
        }
    }()
    
    var trackList: Observable<[TrackList]>
    var title: Observable<String>
    var artist: Observable<String>
    var image: Driver<UIImage?> = .just(nil)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, release: Release, image: Driver<UIImage?>) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.trackList = .just(release.tracklist)
        self.title = .just(release.title)
        self.artist = .just(release.artistsSort.uppercased())
        self.image = image
    }
}


