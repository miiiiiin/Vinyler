//
//  UIViewController+Rx.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {

    public var viewDidLoad: ControlEvent<Void> {
        let event = methodInvoked(#selector(Base.viewDidLoad)).mapVoid()
        return ControlEvent(events: event)
    }

    public var viewDidAppear: ControlEvent<Void> {
        let event = methodInvoked(#selector(Base.viewDidAppear)).mapVoid()
        return ControlEvent(events: event)
    }
}
