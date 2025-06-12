//
//  LoadingViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/3/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import Action
import UIKit

protocol LoadingViewModelInput {
    var albumAction: Action<Release, Void> { get }
    var artistAction: Action<Artist, Void> { get }
    var dismissAction: CocoaAction { get }
}

protocol LoadingViewModelOutput {
    var resourceUrl: Observable<String?> { get }
    var barcode: Observable<String?> { get }
    var artistResourceUrl: Observable<String?> { get }
}

protocol LoadingViewModelType {
    var input: LoadingViewModelInput { get }
    var output: LoadingViewModelOutput { get }
}

class LoadingViewModel: LoadingViewModelInput, LoadingViewModelOutput, LoadingViewModelType {
    
    var input: LoadingViewModelInput { return self }
    var output: LoadingViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var albumAction: Action<Release, Void> = {
        Action<Release, Void> { [unowned self] input in
            let viewModel = AlbumViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, release: input)
            
            let scene = Scene.album(viewModel)
            return self.sceneCoordinator.transition(to: scene)
        }
    }()
    
    lazy var artistAction: Action<Artist, Void> = {
        Action<Artist, Void> { [unowned self] input in
            let viewModel = ArtistViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, artistInfo: input)
            let scene = Scene.artist(viewModel)
            return self.sceneCoordinator.transition(to: scene)
        }
    }()
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
        }
    }()
    
    var resourceUrl: Observable<String?>
    var barcode: Observable<String?>
    var artistResourceUrl: Observable<String?>
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, barcode: String?, resourceUrl: String?, artistResourceUrl: String?) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.resourceUrl = .just(resourceUrl)
        self.barcode = .just(barcode)
        self.artistResourceUrl = .just(artistResourceUrl)
    }
}
