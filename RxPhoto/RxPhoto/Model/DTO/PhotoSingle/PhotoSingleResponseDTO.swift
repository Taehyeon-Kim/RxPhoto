//
//  PhotoSingleResponseDTO.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

struct PhotoSingleResponseDTO: Decodable {
    let id: String
    let color: String
    let user: User
    let urls: Urls

    struct User: Decodable {
        let username: String
    }

    struct Urls: Decodable {
        let full: String
    }
}

extension PhotoSingleResponseDTO {
    func toDomain() -> Photo {
        return Photo(id: id, imageURL: URL(string: urls.full)!)
    }
}
