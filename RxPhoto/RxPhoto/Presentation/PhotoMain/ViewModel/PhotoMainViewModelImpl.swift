//
//  PhotoMainViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

import RxSwift
import RxCocoa

protocol PhotoMainViewModel {
    var navigationTitle: BehaviorRelay<String> { get }
    var photos: BehaviorRelay<[Photo]> { get }
    
    func fetchPhotos() -> Single<[Photo]>
}

final class PhotoMainViewModelImpl: PhotoMainViewModel {

    var navigationTitle = BehaviorRelay(value: "Explore")
    var photos = BehaviorRelay<[Photo]>(value: [])

    private var currentPage = 0
    private var perPage = 10

    func fetchPhotos() -> Single<[Photo]> {
        return Single<[Photo]>.create { observer in
            let requestDTO = PhotoListRequestDTO(page: self.currentPage, perPage: self.perPage)
            
            PhotoService.shared.fetchPhotoList(with: requestDTO) { result in
                switch result {
                case .success(let data):
                    let photos = data.map { $0.toDomain() }
                    self.photos.accept(photos)
                    observer(.success(photos))
            
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
