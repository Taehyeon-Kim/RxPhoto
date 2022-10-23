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
    ) -> AnyPublisher<[Photo], Error> {

        let urlPath = "\(APIKey.searchURL)\(query)"
        var urlRequest = URLRequest(url: URL(string: urlPath)!)
        urlRequest.setValue(APIKey.authorization, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: PhotoResponseDTO.self, decoder: JSONDecoder())
            .map { response in
                return response.results.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
}
