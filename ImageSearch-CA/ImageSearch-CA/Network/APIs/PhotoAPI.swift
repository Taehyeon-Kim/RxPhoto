//
//  PhotoAPI.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/25.
//

import Foundation

enum PhotoAPI {}

extension PhotoAPI {
    
    struct Photos: NetworkAPIDefinition {
        typealias Response = PhotoResponseDTO
        
        let urlInfo: URLInfo
        let requestInfo: RequestInfo<EmptyParameter> = .init(
            method: .get,
            headers: [
                "Authorization": APIKey.authorization
            ]
        )
        
        init(query: String) {
            self.urlInfo = .PhotoAPI(path: "/search/photos", query: query)
        }
    }
}

extension NetworkAPI.URLInfo {
    static func PhotoAPI(path: String, query: String) -> Self {
        return .init(host: "api.unsplash.com", path: path, query: ["query": query])
    }
}
