//
//  Requestable.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
    var sampleData: Data? { get }
}

extension Requestable {
    
    /// URL 생성
    func makeURL() throws -> URL {
        /// URL 생성
        let urlPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: urlPath) else { throw NetworkError.components }
        
        /// Query 추가
        var urlQueryItems: [URLQueryItem] = []
        if let queryParameters = try queryParameters?.toDictionary() {
            urlQueryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        // 최종 URL 생성
        guard let url = urlComponents.url else { throw NetworkError.components }
        return url
    }
    
    /// URLRequest 생성
    func makeURLRequest() throws -> URLRequest {
        let url = try makeURL()
        var urlRequest = URLRequest(url: url)
        
        // method
        urlRequest.httpMethod = method.rawValue
        
        // body
        if let bodyParameters = try bodyParameters?.toDictionary(),
           !bodyParameters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }
        
        // header
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        return urlRequest
    }
}
