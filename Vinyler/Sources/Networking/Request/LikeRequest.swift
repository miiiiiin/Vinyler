//
//  LikeRequest.swift
//  Vinyler
//
//  Created by Songkyung Min on 4/2/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

public struct LikeRequest: Encodable {
    let discogsId: Int
    let title: String
    let artistsSort: String
    let lowestPrice: Double?
    let notes: String?
    let images: [Image]
    let tracklist: [TrackList]
    let releasedFormatted: String?
    let formats: [Format]
    let uri: String?
    let status: String
    var videos: [Videos]?
    let artists: [ArtistDetail]
    
    static func transform(release: Release) -> LikeRequest {
        return LikeRequest(discogsId: release.id, title: release.title, artistsSort: release.artistsSort, lowestPrice: release.lowestPrice, notes: release.notes, images: release.images, tracklist: release.tracklist, releasedFormatted: release.releasedFormatted, formats: release.formats, uri: release.uri, status: release.status, videos: release.videos, artists: release.artists)
    }
}
