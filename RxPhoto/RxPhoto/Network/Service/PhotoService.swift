//
//  PhotoService.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

import Alamofire

final class PhotoService {
    
    static let shared = PhotoService()
    
    private init() {}
    
    func fetchPhotoList(
        with request: PhotoListRequestDTO,
        completion: @escaping (Result<[PhotoListResponseDTO], NetworkError>) -> Void
    ) {
        let urlPath = Environment.baseURL + EndpointPath.listPhoto.path
        guard let parameter = try? request.toDictionary() else { return }
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(Secrets.accessKey)"]
        
        AF.request(urlPath, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: [PhotoListResponseDTO].self) { result in
                switch result.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure:
                    completion(.failure(.decodeError))
                }
            }
    }
    
    func searchPhotoList(
        with request: PhotoSearchRequestDTO,
        completion: @escaping (Result<PhotoSearchResponseDTO, NetworkError>) -> Void
    ) {
        let urlPath = Environment.baseURL + EndpointPath.searchPhoto.path
        guard let parameter = try? request.toDictionary() else { return }
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(Secrets.accessKey)"]
        
        AF.request(urlPath, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: PhotoSearchResponseDTO.self) { result in
                switch result.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure:
                    completion(.failure(.decodeError))
                }
            }
    }
    
    func fetchSinglePhoto(
        id: String,
        completion: @escaping (Result<PhotoSingleResponseDTO, NetworkError>) -> Void
    ) {
        let urlPath = Environment.baseURL + EndpointPath.singlePhoto(id: id).path
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(Secrets.accessKey)"]
        
        AF.request(urlPath, method: .get, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: PhotoSingleResponseDTO.self) { result in
                switch result.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure:
                    completion(.failure(.decodeError))
                }
            }
    }
}
