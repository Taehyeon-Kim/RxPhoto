//
//  PhotoResponseDTO+Mapping.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation

struct PhotoResponseDTO: Codable {
    let total, totalPages: Int
    let results: [PhotoDTO]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

extension PhotoResponseDTO {
    
    struct PhotoDTO: Codable {
        let id: String
        let likes: Int
        let description: String
        let user: User
        let urls: Urls
    }
    
    struct Urls: Codable {
        let raw, full, regular, small: String
        let thumb, smallS3: String

        private enum CodingKeys: String, CodingKey {
            case raw, full, regular, small, thumb
            case smallS3 = "small_s3"
        }
    }
    
    struct User: Codable {
        let username: String
        let name: String
    }
}

/// 당장은 각각의 struct에 대해 변환이 필요가 없어서 하나만 도메인 모델로 변환
extension PhotoResponseDTO.PhotoDTO {
    
    func toDomain() -> Photo {
        return Photo(
            id: id,
            desc: description,
            author: user.username,
            imagePath: urls.small
        )
    }
}
