//
//  NetworkServiceTests.swift
//  VinylerTests
//
//  Created by Running Raccoon on 2022/02/24.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Vinyler

class NetworkServiceTests: XCTestCase {

    private var networkService: NetworkServiceType!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        self.networkService = NetworkService()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }
    
    func test_network() {
//        networkManager.get(type: SidedishItem.self, endpoint: .main)
//            .subscribe(onNext: { _ in })
//            .disposed(by: disposeBag)
//
//        let params = sessionManagerStub.requestParameters
//
//        debugPrint("test side params: \(params)")
//
//        XCTAssertEqual(try params?.url.asURL().absoluteString, "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main")
//        XCTAssertEqual(params?.method, .get)
        
//        let request = BaseRequest(endpoint: .search(query: "q"))
//
//        let a = networkService.request(request: request)
        
        
        
    }

    
    
}
