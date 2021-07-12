//
//  SettingsCellType.swift
//  Vinyler
//
//  Created by Songkyung Min on 2021/07/12.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation

enum SettingsCellType {
    case general
    case instructions
    case privacy
    
    case rate
    case share
    
    case version
    
    var title: String {
        switch self {
        case .general:
            return "general information"
        case .instructions:
            return "instructions"
        case .privacy:
            return "ethical manifests"
        case .rate:
            return "rate"
        case .share:
            return "share"
        case .version:
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                return "App Version" + " " + version
            }
            return ""
        }
    }
}
