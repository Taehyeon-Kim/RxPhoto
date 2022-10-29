//
//  PhotoListResponseDTO.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation
import UIKit

struct PhotoListResponseDTO: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: Urls
    let user: User

    struct Urls: Decodable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }

    struct User: Decodable {
        let username: String
    }
}

extension PhotoListResponseDTO {
    func toDomain() -> Photo {
        return Photo(id: id, imageURL: URL(string: urls.full)!)
    }
}
