//
//  SearchPhotoViewModel.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

final class SearchPhotoViewModel {
    
    private var cancellable = Set<AnyCancellable>()
    private let searchPhotoUseCase: SearchPhotoUseCase
    
    @Published var combineItems: [Photo] = []
    
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
        searchPhotoUseCase.execute(with: .init(query: query, page: 1))
            .map(\.results)
            .assertNoFailure()
            .sink { photo in
                self.combineItems = photo.map { $0.toDomain() }
            }
            .store(in: &cancellable)
    }
}
