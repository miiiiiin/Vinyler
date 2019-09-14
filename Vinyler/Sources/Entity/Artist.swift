//
//  Artist.swift
//  Vinyler
//
//  Created by Min on 14/09/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let name: String
    let profileText: String?
    let members: [ArtistDetail]?
    let images: [Image]
    
    var type: String {
        guard let members = members else {
            return .artist }
        return members.count > 1 ? .band : .artist
    }
}
