//
//  SearchByTextViewModel.swift
//  VinylerTests
//
//  Created by Running Raccoon on 2022/02/25.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Vinyler

class SearchByTextViewModel: XCTestCase {

    private var networkServiceMock: NetworkServiceMock!
    private var sceneCoordinator: SceneCoordinatorType!
    private var viewModel: SearchByTextViewModel!
    private var discogUseCase: DiscogsUseCaseType!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        let vc = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        
        sceneCoordinator = SceneCoordinator(window: window)
        
        networkServiceMock = NetworkServiceMock()
        discogUseCase = DiscogsUseCase(repository: DiscogsRepository(networkService: networkServiceMock))
        viewModel = SearchByTextViewModel(sceneCoordinator: sceneCoordinator)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func test_GetSearchResults_OnSuccess() {
        // Given
        
        // When
        
        // Then
    }
    
    
}
