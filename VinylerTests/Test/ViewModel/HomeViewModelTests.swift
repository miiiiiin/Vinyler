//
//  HomeViewModelTests.swift
//  VinylerTests
//
//  Created by Running Raccoon on 2022/02/21.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Vinyler

class HomeViewModelTests: XCTestCase {

    private var networkServiceMock: NetworkServiceMock!
    private var sceneCoordinator: SceneCoordinatorType!
    private var viewModel: HomeViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        let vc = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        
        sceneCoordinator = SceneCoordinator(window: window)
        
        networkServiceMock = NetworkServiceMock()
        viewModel = HomeViewModel(sceneCoordinator: sceneCoordinator)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        disposeBag = nil
    }
    

    func testGetSearchResultsOnSuccess() {
        
        // given
        
        let fetchCount = scheduler.createObserver(Results.self)
        
        // when
        
        viewModel.output.searchList
            .subscribe(fetchCount)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // then
    
        debugPrint("fetchcount check: \(fetchCount.events.count)")
        
        XCTAssertEqual(fetchCount.events.count, 0)
    }
}
