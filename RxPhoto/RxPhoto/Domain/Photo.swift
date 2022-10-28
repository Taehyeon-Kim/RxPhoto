//
//  Photo.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import Foundation

struct Photo: Hashable {
    let id = UUID()
    let imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
}
