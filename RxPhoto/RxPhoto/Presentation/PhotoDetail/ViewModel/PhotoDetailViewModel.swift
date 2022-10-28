//
//  PhotoDetailViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

import RxSwift
import RxRelay

protocol PhotoDetailViewModel {
    var photo: PublishRelay<Photo> { get }
    
    func load()
}

final class PhotoDetailViewModelImpl: PhotoDetailViewModel {
    
    let provider: Provider
    
    let id: String
    var photo = PublishRelay<Photo>()
    
    init(
        provider: Provider,
        id: String
    ) {
        self.provider = provider
        self.id = id
    }
    
    func load() {
        let endpoint = APIEndpoints.fetchSinglePhoto(id: id)
        provider.request(with: endpoint) { result in
            switch result {
            case .success(let data):
                let photo = data.toDomain()
                self.photo.accept(photo)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
