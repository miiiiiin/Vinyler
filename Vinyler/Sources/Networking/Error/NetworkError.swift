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
        
        typealias CustomError = Vinyler.NetworkError
        
        // MARK: - Database Error -
        case ERR_DB_NO_DATA
        
        // MARK: - Send File Error -
        case ERR_SEND_FILE_FAILED
        
        init?(statusCode: Int, message: String?) {
            switch statusCode {
            case 3000:
                self = .ERR_DB_NO_DATA
            case 2000:
                self = .ERR_SEND_FILE_FAILED
            default:
                self = .ERR_DB_NO_DATA
            }
        }
    }
}
