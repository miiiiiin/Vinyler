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
    var errorEvent: Observable<Error> { get }
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
    
    // MARK: - Output -
    var release: Observable<Release> = .just(nil)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    private let barcode: String?
    private let resourceUrl: String?
    private let artistResourceUrl: String?
    private let errorHandlerRelay = PublishRelay<Error>()
    
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
        if let barcode = barcode {
            self.release = useCase.search(query: barcode)
                .flatMap { results -> Observable<Release> in
                    guard let url = results.first?.resourceUrl else {
                        return Observable.error(RequestError.noResults)
                    }
                    return self.useCase.fetchRelease(path: url)
                }
        } else if let url = resourceUrl {
            self.release = useCase.fetchRelease(path: url)
        } else if let artistUrl = artistResourceUrl {
            self.release = useCase.fetchArtist(path: artistUrl)
        } else {
            self.release = Observable.error(RequestError.invalidUrl)
        }
        return handleObservable(self.release)
    }
    
    private func fetchRelease(from url: String) -> Observable<Release> {
        useCase.fetchRelease(path: url)
    }
    
    private func fetchArtist(from url: String) -> Observable<Release> {
        useCase.fetchArtist(path: url)
    }
    
    private func handleObservable<T>(_ observable: Observable<T>) -> Observable<T> {
        return observable
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .retry(when: errorHandler)
            .catch { [weak self] error in
                self?.errorHandlerRelay.accept(error)
                return Observable.error(error)
            }
    }
    
    private func errorHandler(_ errorObservable: Observable<Error>) -> Observable<Void> {
        return errorObservable.flatMap { [weak self] error -> Observable<Void> in
            self?.errorHandlerRelay.accept(error)
            return Observable.error(error)
        }
    }
    
    var errorEvent: Observable<Error> {
        return errorHandlerRelay.asObservable()
    }
    
}
