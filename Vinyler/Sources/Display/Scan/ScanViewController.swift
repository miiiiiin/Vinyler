//
//  ScanViewController.swift
//  Vinyler
//
//  Created by 민송경 on 15/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class ScanViewController: UIViewController {
    
    private let back = UIButton.back
    private let session = AVCaptureSession()
    let helpLabel = UILabel.header
    let cameraPermission = UILabel.header
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSession()
        setUpEvent()
    }
    
    private func setUpSession() {
       
//        if let device = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: device) {
//            session.addInput(input)
//        }
        
        guard let captureDevice = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
//        if let input = try? AVCaptureDeviceInput(device: captureDevice) {
            session.addInput(input)
//        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        session.addOutput(metadataOutput)
        
        if metadataOutput.availableMetadataObjectTypes.contains(.ean13) {
            metadataOutput.metadataObjectTypes = [.ean13]
        }
        
        metadataOutput.rx.didOutput.map { metadata in
            return metadata.compactMap { $0 as? AVMetadataMachineReadableCodeObject }.first
            }.do(onNext: { [weak self] _ in
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                self?.session.stopRunning()
            })
            .flatMap { barcode -> Observable<String> in
                if let barcodeString = barcode?.stringValue {
                    return Observable.just(barcodeString) //"5060124900964"
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
            }).disposed(by: disposeBag)
    }
    
    private func setUpEvent() {
        back.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] bool in
                if bool {
                    DispatchQueue.main.async {
                        self?.setUpSession()
                    }
                } else {
                    self?.cameraPermission.isHidden = false
                }
            }
        case .restricted:
            self.cameraPermission.isHidden = false
            self.helpLabel.isHidden = true
        case .denied:
            self.cameraPermission.isHidden = false
            self.helpLabel.isHidden = true
        case .authorized:
            self.helpLabel.isHidden = false
            self.session.startRunning()
        }
        
        if session.isRunning == false {
            DispatchQueue.global().async { [weak self] in
//                self?.session.startRunning()
                self?.setUpSession()
            }
        }
    }
    
    override func loadView() {
        let root = UIView.background
        let preview = PreviewView(session: session)
        let targetView = CameraTargetView(forAutoLayout: ())
        
        [preview, targetView, cameraPermission, helpLabel].forEach(root.addSubview)
        [back, helpLabel].forEach(preview.addSubview)
        
        back.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 33).isActive = true
        back.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 35).isActive = true
        preview.topAnchor.constraint(equalTo: root.topAnchor).isActive = true
        preview.leadingAnchor.constraint(equalTo: root.leadingAnchor).isActive = true
        preview.trailingAnchor.constraint(equalTo: root.trailingAnchor).isActive = true
        preview.heightAnchor.constraint(equalTo: root.heightAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: 145).isActive = true
        targetView.leadingAnchor.constraint(equalTo: preview.leadingAnchor, constant: 55).isActive = true
        targetView.centerXAnchor.constraint(equalTo: preview.centerXAnchor).isActive = true
        targetView.centerYAnchor.constraint(equalTo: preview.centerYAnchor).isActive = true
    cameraPermission.topAnchor.constraint(equalTo:targetView.bottomAnchor, constant: 120).isActive = true
        cameraPermission.leftAnchor.constraint(equalTo: helpLabel.leftAnchor).isActive = true
        cameraPermission.widthAnchor.constraint(equalToConstant: 220).isActive = true
        helpLabel.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 100).isActive = true
        helpLabel.widthAnchor.constraint(equalToConstant: 287).isActive = true
        helpLabel.leadingAnchor.constraint(equalTo: preview.leadingAnchor, constant: 44).isActive = true
        helpLabel.bottomAnchor.constraint(equalTo: preview.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        
        self.view = root
        
        helpLabel.set(headerText: .scan)
        cameraPermission.text = .cameraPermission
        cameraPermission.textColor = .white
        cameraPermission.isHidden = true
        
        back.tintColor = .white
        helpLabel.textColor = .white
        
        preview.backgroundColor = .gray
        targetView.backgroundColor = .clear
        targetView.layer.shadowColor = UIColor.dark.cgColor
        targetView.layer.shadowOffset = CGSize(width: 1, height: 1)
        targetView.layer.shadowOpacity = 0.9
        targetView.layer.shadowRadius = 3
    }
}

extension ScanViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let presentingNC = presenting as? UINavigationController,
            presentingNC.topViewController?.isKind(of: ScanViewController.self) ?? false,
            let presentedNC = presented as? UINavigationController,
            presentedNC.viewControllers.first?.isKind(of: LoadingViewController.self) ?? false {
            return PresentLoadingAnimationController()
        }
        return nil
    }
}
