//
//  Environment.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

enum Environment {
    case dev
}

extension Environment {
    var baseURL: String {
        return "https://api.unsplash.com"
    }
}

enum EndpointPath {
    case randomPhoto
    case singlePhoto(id: String)
    case searchPhoto
    case listPhoto
}

extension EndpointPath {
    var path: String {
        switch self {
        case .randomPhoto:
            return "/photos/random"
        case .singlePhoto(let id):
            return "/photos/\(id)"
        case .searchPhoto:
            return "/search/photos"
        case .listPhoto:
            return "/photos"
        }
    }
}

