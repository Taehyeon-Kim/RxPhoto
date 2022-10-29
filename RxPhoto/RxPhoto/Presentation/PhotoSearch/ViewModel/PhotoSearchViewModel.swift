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
    
    var navigationTitle: BehaviorRelay<String> { get }
    var photos: BehaviorRelay<[Photo]> { get }

    func search(with query: String)
}

final class PhotoSearchViewModelImpl: PhotoSearchViewModel {
    // 질문(데이터에 대한 부분을 뷰모델에서 관리해야할 것 같아서 데이터 소스 부분을 여기로 가져왔는데 적절한건지 궁금!
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
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
                
                var snapshot = self.dataSource.snapshot()
                // 섹션을 여러번 추가해주려고 하면 에러가 발생
                // Diffable data source detected an attempt to insert or append 1 section identifier that already exists in the snapshot
                // 처음 로드할때는 섹션을 넣어주는 작업이 필요한데 그 이후에는 필요하지 않은 코드이기 때문에 분기처리 필요
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([0])
                }
                snapshot.appendItems(self.photos.value)
                self.dataSource.apply(snapshot, animatingDifferences: true)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
