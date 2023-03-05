//
//  SceneCoordinatorType.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void>
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
    
    @discardableResult
    func dismiss(animated: Bool) -> Completable
    
    @discardableResult
    func dismissAll(animated: Bool) -> Completable
    
    @discardableResult
    func popToScene(to scene: TargetScene, animated: Bool) -> Completable
    
    @discardableResult
    func handleTabBar(show: Bool) -> Observable<Void>
}
