//
//  SceneCoordinatorType.swift
//  Vinyler
//
//  Created by Running Raccoon on 2022/02/18.
//  Copyright © 2022 songkyung min. All rights reserved.
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
}
