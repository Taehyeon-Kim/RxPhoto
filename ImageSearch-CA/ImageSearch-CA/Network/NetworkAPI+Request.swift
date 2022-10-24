//
//  NetworkAPI+Request.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/24.
//

import Foundation

extension NetworkAPI {
    /// Request에 필요한 정보를 세팅
    /// method, header, parameters 등이 들어감
    struct RequestInfo<T: Encodable> {
        typealias Headers = [String: String]
        typealias Parameters = T
        
        var method: Method
        var headers: Headers?
        var parameters: Parameters?
        
        init(
            method: Method,
            headers: Headers? = nil,
            parameters: Parameters? = nil
        ) {
            self.method = method
            self.headers = headers
            self.parameters = parameters
        }
    }
}

extension NetworkAPI.RequestInfo {
    func requests(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // 전송 시 사용할 파라미터는 인코딩 필요
        request.httpBody = parameters.flatMap {
            try? JSONEncoder().encode($0)
        }
        
        /// merge란?
        /// ```swift
        /// var dictionary = ["a": 1, "b": 2]
        /// dictionary.merge(zip(["a", "c"], [3, 4])) { (current, _) in current }
        /// dictionary.merge(zip(["a", "d"], [5, 6])) { (_, new) in new }
        headers.map {
            request.allHTTPHeaderFields?.merge($0) { cur, new in cur }
        }
        return request
    }
}
