//
//  ActionSheetOption.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

enum ActionSheetOption {
    
    case artistDetails
    case tracklist
    
    var title: String {
        switch self {
        case .artistDetails:
            return .artistDetails
        case .tracklist:
            return .tracklist
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .artistDetails:
            return #imageLiteral(resourceName: "myVinyls")
        case .tracklist:
            return #imageLiteral(resourceName: "list")
        }
    }
}
