//
//  SearchPhotoDTO.swift
//  Network
//
//  Created by taekki on 2022/10/20.
//  Copyright © 2022 taekki. All rights reserved.
//

import Foundation

public struct SearchPhotoDTO: Codable, Hashable {
     
    public let total, totalPages: Int
    public let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
public struct SearchResult: Codable, Hashable {
     
    public let id: String
    public let urls: Urls
    public let likes: Int

    enum CodingKeys: String, CodingKey {
        case id
        case urls, likes
    }
}

public struct Urls: Codable, Hashable {
    public let raw, full, regular, small: String
    public let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

public extension SearchPhotoDTO {
    
    static func empty() -> Self {
        SearchPhotoDTO(total: 0, totalPages: 0, results: [])
    }
}

