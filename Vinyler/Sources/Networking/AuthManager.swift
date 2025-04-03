//
//  AuthManager.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/29/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "accessToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "accessToken") }
    }
}
