//
//  SearchPhotoViewModel.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation

import RxSwift
import RxRelay

final class SearchPhotoViewModel {
    
    private let searchPhotoUseCase: SearchPhotoUseCase
    
    private var photos: [Photo] = []
    let items: BehaviorRelay<[Photo]> = BehaviorRelay(value: [])
    
    init(
        searchPhotoUseCase: SearchPhotoUseCase
    ) {
        self.searchPhotoUseCase = searchPhotoUseCase
    }
    
    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(query: query)
    }
    
    private func update(query: String) {
        load(query: query)
    }
    
    func load(query: String) {
        searchPhotoUseCase.execute(
            with: .init(query: query, page: 1)) { [weak self] result in
                switch result {
                case let .success(photos):
                    self?.photos = photos
                    self?.items.accept(photos)
                    
                case let .failure(error):
                    print(error)
                }
            }
    }
}
