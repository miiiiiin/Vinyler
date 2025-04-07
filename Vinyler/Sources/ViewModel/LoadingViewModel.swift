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
import Action

protocol LoadingViewModelInput {
    var moveAction: Action<Release, Void> { get }
}

protocol LoadingViewModelOutput {
    var release: Observable<Release> { get }
    var artist: Observable<Artist> { get }
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
            //            let viewModel = AlbumViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase, release: input)
            //
            //            return self.sceneCoordinator.transition(to: Scene.album(viewModel))
            
            return .just(())
        }
    }()
    
    // MARK: - Output -
    var release: Observable<Release>
    var artist: Observable<Artist>
    
    var errorEvent: Observable<Error> {
        return errorHandlerRelay.asObservable()
    }
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: VinylUseCase
    private let barcode: String?
    private let resourceUrl: String?
    private let artistResourceUrl: String?
    private let errorHandlerRelay: PublishRelay<Error>
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: VinylUseCase, barcode: String? = nil,
         resourceUrl: String? = nil,
         artistResourceUrl: String? = nil) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        self.barcode = barcode
        self.resourceUrl = resourceUrl
        self.artistResourceUrl = artistResourceUrl
        self.errorHandlerRelay = PublishRelay<Error>()
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
            self.artist = useCase.fetchArtist(path: artistUrl)
//            handleObservable(self.artist)
        } else {
            self.release = Observable.error(RequestError.invalidUrl)
        }
//        handleObservable(self.release)
    }
    
    private func fetchRelease(from url: String) -> Observable<Release> {
        useCase.fetchRelease(path: url)
    }
    
    private func fetchArtist(from url: String) -> Observable<Artist> {
        useCase.fetchArtist(path: url)
    }
    
    private func handleObservable<T>(_ observable: Observable<T>) -> Observable<T> {
        return observable
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .retry(when: { [weak self] errorObservable in
                errorObservable.flatMap { error -> Observable<Void> in
                    self?.errorHandlerRelay.accept(error)
                    return Observable.error(error)
                }
            })
            .catch { [weak self] error in
                self?.errorHandlerRelay.accept(error)
                return Observable.error(error)
            }
            .observe(on: MainScheduler.instance)
    }

    
    private func errorHandler(_ errorObservable: Observable<Error>) -> Observable<Void> {
        return errorObservable.flatMap { [weak self] error -> Observable<Void> in
            self?.errorHandlerRelay.accept(error)
            return Observable.error(error)
        }
    }
    
}
