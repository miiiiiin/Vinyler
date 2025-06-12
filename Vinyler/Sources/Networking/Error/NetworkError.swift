//
//  NetworkError.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: String
    let message: String
}

enum Vinyler {
    public enum NetworkError: Error {
        
        // MARK: - Server Error -
        case serverError(statusCode: Int, message: String?)
        case unknownError
        
        init?(statusCode: Int, message: String?) {
            if (200..<300).contains(statusCode) {
                // 정상적인 응답이므로 에러 아님
                return nil
            }
            self = .serverError(statusCode: statusCode, message: message)
        }
    }
}

extension Vinyler.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .serverError(statusCode, message):
            return "서버 오류 (\(statusCode)): \(message ?? "알 수 없는 오류")"
        case .unknownError:
            return "알 수 없는 네트워크 오류 발생"
        }
    }
    
    var statusCode: Int {
        switch self {
        case let .serverError(statusCode, message):
            return statusCode
        case .unknownError:
            return 500
        }
    }
}
