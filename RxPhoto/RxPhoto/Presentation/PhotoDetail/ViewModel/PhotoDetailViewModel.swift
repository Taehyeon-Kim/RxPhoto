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
    
    func fetchSinglePhoto()
}

final class PhotoDetailViewModelImpl: PhotoDetailViewModel {
    
    private let id: String
    var photo = PublishRelay<Photo>()
    
    init(id: String) {
        self.id = id
    }
    
    func fetchSinglePhoto() {
        PhotoService.shared.fetchSinglePhoto(id: id) { result in
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
