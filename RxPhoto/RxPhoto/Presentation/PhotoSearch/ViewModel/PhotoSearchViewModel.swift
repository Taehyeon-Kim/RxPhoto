//
//  PhotoSearchViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import Foundation

import RxRelay
import RxSwift

protocol PhotoSearchViewModel {
    var navigationTitle: BehaviorRelay<String> { get }
    var photos: BehaviorRelay<[Photo]> { get }

    func search(with query: String)
}

final class PhotoSearchViewModelImpl: PhotoSearchViewModel {
    
    var navigationTitle = BehaviorRelay(value: "PhotoSearch")
    var photos = BehaviorRelay<[Photo]>(value: [])
    
    private var currentPage: Int = 0
    private var query = ""
    
    func search(with query: String = "") {
        let searchQuery = query.isEmpty ? self.query : query
        let query = searchQuery.isEmpty ? nil : searchQuery     // 가장 처음인 경우에는 nil이 만들어질 수 있음
        guard let query else { return }
        self.query = query
        
        let request = PhotoSearchRequestDTO(query: searchQuery, page: currentPage)
        PhotoService.shared.searchPhotoList(with: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let photos = data.toDomain()
                self.photos.accept(photos)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
