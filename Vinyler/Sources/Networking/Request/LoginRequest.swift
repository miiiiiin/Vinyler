//
//  LoginRequest.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct LoginRequest: Encodable {
    var email: String?
    var password: String?
}
