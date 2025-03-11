//
//  Extensions+String.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/10/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

extension String {
    
    var jsonStringToDictionary: [String: AnyObject]? {
        if let data = data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] } catch let error as NSError {
                    print(error)
                }
        }
        return nil
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}
