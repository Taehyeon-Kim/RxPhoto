//
//  PhotoRepositoryImpl.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

import Alamofire

final class PhotoRepositoryImpl: PhotoRepository {
    func fetchPhotoList(
        query: String,
        page: Int,
        completion: @escaping (Result<[Photo], Error>) -> Void
    ) {

        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(
            url,
            method: .get,
            headers: header
        ).responseDecodable(of: PhotoResponseDTO.self) { response in

            switch response.result {
            case let .success(data):
                let photos = data.results.map { $0.toDomain() }
                completion(.success(photos))
            
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
