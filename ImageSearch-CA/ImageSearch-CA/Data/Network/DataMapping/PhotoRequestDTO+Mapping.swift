//
//  PhotoRequestDTO+Mapping.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation

struct PhotoRequestDTO: Encodable {
    let query: String
    let page: Int
}
