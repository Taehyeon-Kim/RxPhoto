//
//  NetworkAPIDefinition.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/24.
//

import Foundation

protocol NetworkAPIDefinition {
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    var urlInfo: NetworkAPI.URLInfo { get }
    var method: NetworkAPI.Method { get }   
    var headers: [String: String]? { get }  // header 옵셔널
    var parameters: Parameter? { get }      // body paramter
}
