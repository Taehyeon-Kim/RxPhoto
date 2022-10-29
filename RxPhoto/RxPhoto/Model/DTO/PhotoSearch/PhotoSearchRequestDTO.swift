//
//  PhotoSearchRequestDTO.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

struct PhotoSearchRequestDTO: Codable {
    let query: String
    let page: Int
    var perPage: Int = 10

    enum CodingKeys: String, CodingKey {
        case query
        case page
        case perPage = "per_page"
    }
}
