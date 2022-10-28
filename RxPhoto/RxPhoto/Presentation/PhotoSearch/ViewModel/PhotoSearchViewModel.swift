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
    var dummy: BehaviorRelay<[Photo]> { get }
    
    func load()
}

final class PhotoSearchViewModelImpl: PhotoSearchViewModel {
    // 질문(데이터에 대한 부분을 뷰모델에서 관리해야할 것 같아서 데이터 소스 부분을 여기로 가져왔는데 적절한건지 궁금
    var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    var navigationTitle = BehaviorRelay(value: "PhotoSearch")
    var dummy = BehaviorRelay(value: Photo.loadDummy())
    
    func load() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(dummy.value)
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}
