//
//  PhotoSearchViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import RxRelay
import RxSwift

protocol PhotoSearchViewModel {
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>! { get set }
    var provider: Provider { get }
    
    var navigationTitle: BehaviorRelay<String> { get }
    var photos: BehaviorRelay<[Photo]> { get }

    func load(with query: String)
}

final class PhotoSearchViewModelImpl: PhotoSearchViewModel {
    // 질문(데이터에 대한 부분을 뷰모델에서 관리해야할 것 같아서 데이터 소스 부분을 여기로 가져왔는데 적절한건지 궁금
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    var provider: Provider
    
    var navigationTitle = BehaviorRelay(value: "PhotoSearch")
    var photos = BehaviorRelay<[Photo]>(value: [])
    
    var currentPage: Int = 0
    var query = ""
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func load(with query: String = "") {
        guard let searchQuery = getSearchQuery(compared: query) else { return }
        self.query = searchQuery
        
        currentPage += 1
        let photoSearchRequestDTO = PhotoSearchRequestDTO(query: searchQuery, page: currentPage)
        let endpoint = APIEndpoints.fetchSearchPhotos(with: photoSearchRequestDTO)
        
        provider.request(with: endpoint) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let responseDTO):
                var snapshot = self.dataSource.snapshot()
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([0])
                }
                let photos = responseDTO.toDomain()
                self.photos.accept(photos)
                snapshot.appendItems(photos)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getSearchQuery(compared query: String) -> String? {
        let searchQuery = query.isEmpty ? self.query : query
        return searchQuery.isEmpty ? nil : searchQuery
    }
}
