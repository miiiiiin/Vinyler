//
//  RxAVCaptureMetadataOutputObjectsDelegate.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa

class RxAVCaptureMetadataOutputObjectsProxy: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate>, DelegateProxyType, AVCaptureMetadataOutputObjectsDelegate {
    
    weak private(set) var output: AVCaptureMetadataOutput?
    
    init(output: ParentObject) {
        self.output = output
        super.init(parentObject: output, delegateProxy: RxAVCaptureMetadataOutputObjectsProxy.self)
    }
    
    static func registerKnownImplementations() {
        register { RxAVCaptureMetadataOutputObjectsProxy(output: $0) }
    }
    
    static func currentDelegate(for object: AVCaptureMetadataOutput) -> AVCaptureMetadataOutputObjectsDelegate? {
        return object.metadataObjectsDelegate
    }
    
    static func setCurrentDelegate(_ delegate: AVCaptureMetadataOutputObjectsDelegate?, to object: AVCaptureMetadataOutput) {
        object.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
    }
}

extension Reactive where Base: AVCaptureMetadataOutput {
    
    var delegate: DelegateProxy<AVCaptureMetadataOutput, AVCaptureMetadataOutputObjectsDelegate> {
        return RxAVCaptureMetadataOutputObjectsProxy.proxy(for: base)
    }
    
    var didOutput: Observable<[AVMetadataObject]> {
        return delegate.methodInvoked(#selector(AVCaptureMetadataOutputObjectsDelegate.metadataOutput(_:didOutput:from:)))
            .map { args in
                let metadataObjects = args[1] as? [AVMetadataObject]
                return metadataObjects ?? []
        }
    }
}

