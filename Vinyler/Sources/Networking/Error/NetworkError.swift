//
//  NetworkError.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

enum Vinyler {
    public enum NetworkError: Error {
        
        // MARK: - Database Error -
        case databaseNoData
        
        // MARK: - Send File Error -
        case sendFileFailed
        
        init?(statusCode: Int, message: String?) {
            switch statusCode {
            case 3000:
                self = .databaseNoData
            case 2000:
                self = .sendFileFailed
            default:
                self = .databaseNoData
            }
        }
    }
}
