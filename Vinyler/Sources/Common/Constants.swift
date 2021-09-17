//
//  Constants.swift
//  Vinyler
//
//  Created by Running Raccoon on 2021/09/13.
//  Copyright © 2021 songkyung min. All rights reserved.
//

import Foundation

struct Constants {
    
    struct GoogleAds {
        static var adKey: String {
            (Bundle.main.infoDictionary?["AD_MOB_KEY"] as? String ?? "")
        }

        static var testAdKey: String {
            (Bundle.main.infoDictionary?["AD_MOB_TEST_KEY"] as? String ?? "")
        }
    }
    
    struct Discogs {
        
        static var discogKey: String {
            (Bundle.main.infoDictionary?["DISCOG_KEY"] as? String ?? "")
        }
        
        static var discogSecret: String {
            (Bundle.main.infoDictionary?["DISCOG_SECRET"] as? String ?? "")
        }
    }
}
