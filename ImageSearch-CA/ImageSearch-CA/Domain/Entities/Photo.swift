//
//  Photo.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation

/// Domain Model
/// 사용자와 가장 맞닿아 있는 데이터
struct Photo: Hashable, Identifiable {
    
    typealias ID = String
    
    let id: ID
    let desc: String?
    let author: String?
    let imagePath: String?
}
