//
//  NetworkAPIDefinition.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/24.
//

import Foundation

protocol NetworkAPIDefinition {
    typealias URLInfo = NetworkAPI.URLInfo
    typealias RequestInfo = NetworkAPI.RequestInfo
    
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    // var urlInfo: NetworkAPI.URLInfo { get }
    // var method: NetworkAPI.Method { get }
    // var headers: [String: String]? { get }  // header 옵셔널
    // var parameters: Parameter? { get }      // body paramter
    
    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
}

extension NetworkAPIDefinition {
    func request(completion: @escaping (Result<Response, Error>) -> Void) {
        let url = urlInfo.url
        let request = requestInfo.requests(url: url)
        let config = URLSessionConfiguration.default   // default session object
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
