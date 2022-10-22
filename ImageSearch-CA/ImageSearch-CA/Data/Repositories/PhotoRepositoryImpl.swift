//
//  PhotoRepositoryImpl.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

final class PhotoRepositoryImpl: PhotoRepository {
    func fetchPhotoList(
        query: String,
        page: Int
    ) -> AnyPublisher<PhotoResponseDTO, Error> {

        let urlPath = "\(APIKey.searchURL)\(query)"
        let headers: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        var urlRequest = URLRequest(url: URL(string: urlPath)!)
        urlRequest.headers = headers
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: PhotoResponseDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
