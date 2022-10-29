//
//  Photo.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import Foundation

struct Photo: Hashable {
    let id: String
    let imageURL: URL
    
    init(id: String, imageURL: URL) {
        self.id = id
        self.imageURL = imageURL
    }
}
