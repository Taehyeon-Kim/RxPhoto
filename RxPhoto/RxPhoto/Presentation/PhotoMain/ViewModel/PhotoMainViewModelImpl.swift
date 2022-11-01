//
//  PhotoMainViewModel.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import Foundation

import RxSwift
import RxCocoa

final class PhotoMainViewModelImpl: ViewModelType {
    
    private var disposeBag = DisposeBag()
    private var currentPage = 0
    private var perPage = 10
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let searchButtonTap: ControlEvent<Void>
        
        let navigationTitle: Driver<String>
        let photos: Driver<[Photo]>
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: "Explore").asDriver()
        let photos = PublishSubject<[Photo]>()
        
        fetchPhotos()
            .subscribe { value in
                photos.onNext(value)
            } onFailure: { error in
                photos.onError(error)
            }
            .disposed(by: disposeBag)
        
        return Output(searchButtonTap: input.searchButtonTap,
                      navigationTitle: navigationTitle,
                      photos: photos.asDriver(onErrorJustReturn: []))
    }

    func fetchPhotos() -> Single<[Photo]> {
        return Single<[Photo]>.create { observer in
            let requestDTO = PhotoListRequestDTO(page: self.currentPage, perPage: self.perPage)
            
            PhotoService.shared.fetchPhotoList(with: requestDTO) { result in
                switch result {
                case .success(let data):
                    let photos = data.map { $0.toDomain() }
                    observer(.success(photos))
            
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
