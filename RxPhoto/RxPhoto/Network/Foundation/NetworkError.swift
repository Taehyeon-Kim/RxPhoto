//
//  NetworkError.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .unknownError: return "❌ 알 수 없는 에러"
        case .decodeError: return "❌ 디코딩 에러 발생"
        }
    }
}
