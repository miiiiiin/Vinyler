//
//  Image.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

enum ImageType: String, Codable {
    case primary = "primary"
    case secondary = "secondary"
}

struct Image: Codable {
    let resourceUrl: String
    let type: ImageType
}
