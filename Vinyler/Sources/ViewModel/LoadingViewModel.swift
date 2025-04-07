//
//  LoadingViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/3/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoadingViewModelInput {
    var moveAction: Action<Release, Void> { get }
}

protocol LoadingViewModelOutput {
    var release: Observable<Release> { get }
}

protocol LoadingViewModelType {
    var input: LoadingViewModelInput { get }
    var output: LoadingViewModelOutput { get }
}

class LoadingViewModel: LoadingViewModelInput, LoadingViewModelOutput, LoadingViewModelType {
    
    var input: LoadingViewModelInput { return self }
    var output: LoadingViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var moveAction: Action<Release, Void> = {
        Action<Release, Void> { [unowned self] input in
            let viewModel = AlbumViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, release: input)
            
            return self.sceneCoordinator.transition(to: Scene.album(viewModel))
        }
    }()
    
    var release: Observable<Release> = .just(nil)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    private let barcode: String?
    private let resourceUrl: String?
    private let artistResourceUrl: String?
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, barcode: String? = nil,
         resourceUrl: String? = nil,
         artistResourceUrl: String? = nil) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.barcode = barcode
        self.resourceUrl = resourceUrl
        self.artistResourceUrl = artistResourceUrl
    }
    
    private func fetch() {
        guard let barcode = barcode else {
            if let url = resourceUrl {
                self.release = fetchRelease(from: url)
            } else if let artistUrl = artistResourceUrl {
                self.release = fetchArtist(from: artistUrl)
            }
            return
        }
        
        self.release = useCase.search(query: barcode)
            .flatMap { searchResults -> Observable<Release> in
                guard let firstUrl = searchResults.first?.resourceUrl else {
                    return Observable.error(RequestError.noResults)
                }
                return useCase.fetchRelease(path: firstUrl)
            }
    }
    
    private func fetchRelease(from url: String) {
        useCase.fetchRelease(path: url)
    }
    
    private func fetchArtist(from url: String) {
        useCase.fetchArtist(path: url)
    }
}
