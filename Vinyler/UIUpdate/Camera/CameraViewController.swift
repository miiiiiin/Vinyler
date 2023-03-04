//
//  CameraViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 2022/08/19.
//  Copyright © 2022 songkyung min. All rights reserved.
//

import AVFoundation
import Foundation
import RxCocoa
import RxSwift
import UIKit

class CameraViewController: UIViewController {
    
    let moreButton = UIButton.more
    private let session = AVCaptureSession()
    
    let helpLabel = UILabel.header
    let cameraPermission = UILabel.header
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpSession()
    }
    
    private func setUpSession() {
        guard let captureDevice = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        if session.inputs.isEmpty {
            self.session.addInput(input)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if session.outputs.isEmpty {
            self.session.addOutput(metadataOutput)
        }
        
        if metadataOutput.availableMetadataObjectTypes.contains(.ean13) {
            metadataOutput.metadataObjectTypes = [.ean13]
        }
        
        metadataOutput.rx.didOutput.map { metadata in
            return metadata.compactMap { $0 as? AVMetadataMachineReadableCodeObject }.first
        }.do(onNext: { [weak self] _ in
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self?.session.stopRunning()
        })
            .flatMap { barcode -> Observable<String> in
                if let barcodeString = barcode?.stringValue {
                    return Observable.just(barcodeString)
                } else {
                    return Observable.error(RequestError.noResults)
                }
        }
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] barcode in
            let loadingVC = LoadingViewController(barcode: barcode)
            let nav = NavigationController(rootViewController: loadingVC)
            nav.transitioningDelegate = self
            self?.present(nav, animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let dashboardVC = DashboardViewController()
        let nav = NavigationController(rootViewController: dashboardVC)
//        self.presentPanModal(dashboardVC)
        self.presentPanModal(nav)
        
        DispatchQueue.global().async { [weak self] in
            self?.session.startRunning()
        }
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if !granted {
                    self?.cameraPermission.isHidden = false
                }
            }
        } else if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            self.cameraPermission.isHidden = false
        }
        
        moreButton.rx.tap.subscribe(onNext: { [weak self] in        self?.navigationController?.pushViewController(AppInfoViewController(), animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    override func loadView() {
        let root = UIView.background
        let preview = PreviewView(session: session)
        let targetView = CameraTargetView(forAutoLayout: ())
//        moreButton.tintColor = .white
        [preview, targetView, cameraPermission, moreButton, helpLabel].forEach(root.addSubview)
        
        preview.topAnchor.constraint(equalTo: root.topAnchor).isActive = true
        preview.leadingAnchor.constraint(equalTo: root.leadingAnchor).isActive = true
        preview.trailingAnchor.constraint(equalTo: root.trailingAnchor).isActive = true
        preview.heightAnchor.constraint(equalTo: root.heightAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 145).isActive = true
        targetView.leadingAnchor.constraint(equalTo: preview.leadingAnchor, constant: 55).isActive = true
        targetView.centerXAnchor.constraint(equalTo: preview.centerXAnchor).isActive = true
        targetView.centerYAnchor.constraint(equalTo: preview.centerYAnchor).isActive = true
        cameraPermission.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 120).isActive = true
        cameraPermission.leftAnchor.constraint(equalTo: helpLabel.leftAnchor).isActive = true
        cameraPermission.widthAnchor.constraint(equalToConstant: 220).isActive = true
        helpLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 100).isActive = true
        helpLabel.widthAnchor.constraint(equalToConstant: 287).isActive = true
        helpLabel.leadingAnchor.constraint(equalTo: preview.leadingAnchor, constant: 44).isActive = true
        helpLabel.bottomAnchor.constraint(equalTo: preview.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(root.safeAreaLayoutGuide.snp.top).offset(24)
            
            make.leading.equalToSuperview().offset(24)
        }
        
        self.view = root
        
        helpLabel.set(headerText: .tryScan)
        cameraPermission.text = .cameraPermission
        cameraPermission.textColor = .white
        cameraPermission.isHidden = true
        
        helpLabel.textColor = .white
        
        preview.backgroundColor = .white
        targetView.backgroundColor = .clear
        targetView.layer.shadowColor = UIColor.dark.cgColor
        targetView.layer.shadowOffset = CGSize(width: 1, height: 1)
        targetView.layer.shadowOpacity = 0.9
        targetView.layer.shadowRadius = 3
    }
}

extension CameraViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let presentingNC = presenting as? UINavigationController,
            presentingNC.topViewController?.isKind(of: CameraViewController.self) ?? false,
            let presentedNC = presented as? UINavigationController,
            presentedNC.viewControllers.first?.isKind(of: LoadingViewController.self) ?? false {
            return PresentLoadingAnimationController()
        }
        return nil
    }
}
