//
//  AlbumViewController.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(release: Release) {
        super.init(nibName: nil, bundle: nil)
        
        print(release)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
