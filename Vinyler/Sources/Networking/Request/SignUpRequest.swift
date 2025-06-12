//
//  SignUpRequest.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/23/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    var email: String?
    var password: String?
    var nickname: String?
    var profile: String?
    var birthday: String?
}
