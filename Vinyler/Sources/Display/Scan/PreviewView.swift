//
//  PreviewView.swift
//  Vinyler
//
//  Created by 민송경 on 18/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import AVFoundation
import UIKit

class PreviewView: UIView {

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        videoPreviewLayer?.session = session
        videoPreviewLayer?.videoGravity = .resizeAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer? {
        return layer as? AVCaptureVideoPreviewLayer
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
