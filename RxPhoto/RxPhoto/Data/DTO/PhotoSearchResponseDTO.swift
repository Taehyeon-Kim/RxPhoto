//
//  PhotoSearchResponseDTO.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

struct PhotoSearchResponseDTO: Decodable {
    let total: Int
    let totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }

    struct Result: Decodable {
        let user: User
        let urls: Urls

        struct User: Decodable {
            let username: String
        }

        struct Urls: Decodable {
            let small: String
        }
    }
}

extension PhotoSearchResponseDTO {
    func toDomain() -> [Photo] {
        return results.map {
            Photo(imageURL: URL(string: $0.urls.small)!)
        }
    }
}
