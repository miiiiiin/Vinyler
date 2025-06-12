//
//  VinylerRelease.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/27/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

struct VinylerRelease: Codable {
    let vinylId: Int64
    let discogsId: Int64
    let title: String?
    let likesCount: Int64?
    let artistsSort: String
    let notes: String?
    let releasedFormatted: String?
    let uri: String?
    let status: String
    let images: [Image]
    let tracklist: [TrackList]
    let formats: [Format]
    let artists: [ArtistDetail]
    let videos: [Videos]
    
}
