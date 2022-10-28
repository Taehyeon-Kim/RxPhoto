//
//  Encodable+toDictionary.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

/// Encodable한 객체에 대해서 Dictionary 타입으로 변환할 수 있도록 메서드 작성
/// Query나 Body Parameter와 같은 값들을 바로 Dictionary 타입으로 작성하는 것이 아니라, JSON 객체로 변환해서 전달할 수 있어서 과정이 간편하다.
extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
