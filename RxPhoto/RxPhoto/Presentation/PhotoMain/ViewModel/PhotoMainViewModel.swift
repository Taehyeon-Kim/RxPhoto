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

    var navigationTitle = BehaviorRelay(value: "Explore")
    var photos = BehaviorRelay<[Photo]>(value: [])
    
    var currentPage = 0
    var perPage = 10

    func fetchPhotos() {
        let requestDTO = PhotoListRequestDTO(page: currentPage, perPage: perPage)
        
        PhotoService.shared.fetchPhotoList(with: requestDTO) { result in
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
