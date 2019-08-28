//
//  Release.swift
//  Vinyler
//
//  Created by 민송경 on 21/07/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

struct Release: Codable {
    let id: Int
    let title: String
    let artistsSort: String
    let lowestPrice: Double?
    let notesPlaintext: String?
    let images: [Image]
    let tracklist: [TrackList]
    let releasedFormatted: String?
    let formats: [Format]
    let uri: String?
    let status: String
    var videos: [Videos]?
    
//    var mainArtistResourceUrl: String {
//        return artists.first.map { $0.resourceUrl } ?? ""
//    }
}
