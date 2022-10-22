//
//  PhotoRepository.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

protocol PhotoRepository {
    func fetchPhotoList(query: String, page: Int) -> AnyPublisher<PhotoResponseDTO, Error>
}
