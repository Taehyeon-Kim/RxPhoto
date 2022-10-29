//
//  PhotoMainViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

import RxSwift
import RxCocoa

final class PhotoMainViewModel {
    
    let provider: Provider
    
    var navigationTitle = BehaviorRelay(value: "Explore")
    var photos = BehaviorRelay<[Photo]>(value: [])
    
    var currentPage = 0
    var perPage = 10
    
    init(provider: Provider) {
        self.provider = provider
    }

    func fetchPhotos() {
        let photoListRequestDTO = PhotoListRequestDTO(page: currentPage, perPage: perPage)
        let endpoint = APIEndpoints.fetchPhotoList(with: photoListRequestDTO)
        
        provider.request(with: endpoint) { result in
            switch result {
            case .success(let data):
                let photos = data.map { $0.toDomain() }
                self.photos.accept(photos)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
