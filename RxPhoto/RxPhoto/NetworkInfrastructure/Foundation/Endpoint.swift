//
//  Endpoint.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

typealias RequestAResponsable = Requestable & Responsable

struct Endpoint<R>: RequestAResponsable {
    typealias Response = R
    
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String : String]?
    var sampleData: Data?
    
    init(
        baseURL: String,
        path: String,
        method: HTTPMethod,
        queryParameters: Encodable? = nil,
        bodyParameters: Encodable? = nil,
        headers: [String : String]? = [:],
        sampleData: Data? = nil
    )
    {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.sampleData = sampleData
    }
}
