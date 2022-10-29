//
//  Encodable+toDictionary.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

extension Encodable {
    
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)  // 인코딩
        let jsonData = try JSONSerialization.jsonObject(with: data) // 인코딩한 객체를 json data 형태로 변환
        return jsonData as? [String: Any]
    }
}
