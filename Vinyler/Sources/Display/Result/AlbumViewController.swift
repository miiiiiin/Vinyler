//
//  AlbumViewController.swift
//  Vinyler
//
//  Created by 민송경 on 27/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(release: Release) {
        super.init(nibName: nil, bundle: nil)
        
        print(release)
        
//        Release(id: 862641, title: "Serotone", artistsSort: "Matt O\'Brien", lowestPrice: Optional(3.33), notesPlaintext: Optional("Stickered plastic sleeve. This is the 1st pressing in clear vinyl.\r\n\r\nThe 2nd pressing is in transparent orange vinyl.\r\nThe 3rd pressing in transparent electric <a href=http://www.discogs.com/release/2123933>blue vinyl</a>.\r\nA 4th pressing is in <a href=\"http://www.discogs.com/release/862641\">black vinyl</a>.\r\n\r\nB: Remix and additional production at Studio 56.\r\n\r\nA: 33 rpm. B: 45 rpm.\r\n"), images: [Vinyler.Image(type: Vinyler.ImageType.primary), Vinyler.Image(type: Vinyler.ImageType.secondary), Vinyler.Image(type: Vinyler.ImageType.secondary)], tracklist: [Vinyler.TrackList(duration: "12:00", position: "A", title: "Serotone (Version)"), Vinyler.TrackList(duration: "8:37", position: "B", title: "Serotone (Radio Slave\'s Panorama Garage Remix)")], releasedFormatted: Optional("18 Dec 2006"), formats: [Vinyler.Format(name: "Vinyl", descriptions: ["12\"", "33 ⅓ RPM", "45 RPM"])])

        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
