//
//  PhotoListRequestDTO.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

enum OrderBy: String, Encodable {
    case latest
    case oldest
    case popular
}

struct PhotoListRequestDTO: Encodable {
    let page: Int
    var perPage: Int = 10
    var orderBy: OrderBy = .popular

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
}
