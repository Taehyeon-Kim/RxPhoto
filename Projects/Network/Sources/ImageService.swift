//
//  ImageService.swift
//  Network
//
//  Created by taekki on 2022/10/20.
//  Copyright © 2022 taekki. All rights reserved.
//

import Foundation

import Alamofire

public class ImageService {
    
    typealias CompletionHandler = (SearchPhotoDTO?, Int?, Error?) -> Void
    
    private init() {}
    
    static func searchPhoto(query: String, completion: @escaping CompletionHandler) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhotoDTO.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case let .success(value):
                completion(value, statusCode, nil)
            
            case let .failure(error):
                completion(nil, statusCode, error)
            }
        }
    }
}
