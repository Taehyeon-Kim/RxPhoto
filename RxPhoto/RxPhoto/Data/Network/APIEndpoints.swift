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
            headers: ["Authorization": "Client-ID \(APIKey.secrets)"]
        )
    }
    
    static func fetchSinglePhoto(id: String) -> Endpoint<PhotoSingleResponseDTO> {
        return Endpoint(
            baseURL: Environment.dev.baseURL,
            path: EndpointPath.singlePhoto(id: id).path,
            method: .get,
            headers: ["Authorization": "Client-ID \(APIKey.secrets)"]
        )
    }
    
    static func fetchPhotoList(with photoListRequestDTO: PhotoListRequestDTO) -> Endpoint<[PhotoListResponseDTO]> {
        return Endpoint(
            baseURL: Environment.dev.baseURL,
            path: EndpointPath.listPhoto.path,
            method: .get,
            queryParameters: photoListRequestDTO,
            headers: ["Authorization": "Client-ID \(APIKey.secrets)"]
        )
    }
}
