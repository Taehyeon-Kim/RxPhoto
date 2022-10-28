//
//  APIEndpoints.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/28.
//

import Foundation

enum APIEndpoints {
    
    static func fetchSearchPhotos(with photoSearchRequestDTO: PhotoSearchRequestDTO) -> Endpoint<PhotoSearchResponseDTO> {
        return Endpoint(
            baseURL: Environment.dev.baseURL,
            path: EndpointPath.searchPhoto.path,
            method: .get,
            queryParameters: photoSearchRequestDTO,
            headers: ["Authorization": "Client-ID \(APIKey.secrets)"],
            sampleData: nil
        )
    }
}
