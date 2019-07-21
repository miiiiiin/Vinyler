//
//  MainViewController.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {

    let cameraBtn = UIButton.camera
    let listBtn = UIButton.list
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        DiscogsAPI().search(query: "four") { result in
            print("serach result : \(result)")
        }
    }
}
