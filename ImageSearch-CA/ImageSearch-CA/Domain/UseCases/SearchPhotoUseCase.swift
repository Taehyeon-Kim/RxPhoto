//
//  SearchPhotoUseCase.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

// 동작에 대한 정의를 먼저 진행한다. 우리는 이를 추상화라고 한다.
protocol SearchPhotoUseCase {
    func execute(
        with requestValue: SearchPhotoUseCaseRequestValue,
        completion: @escaping (Result<Photo, Error>) -> Void
    ) -> Cancellable?
}

struct SearchPhotoUseCaseRequestValue {
    let query: String
    let page: Int
}

final class SearchPhotoUseCaseImpl: SearchPhotoUseCase {
    /// 사진 검색을 수행하는 레포지터리
    // private let photoRepository: PhotoRepository
    
    init() {
        
    }
    
    func execute(
        with requestValue: SearchPhotoUseCaseRequestValue,
        completion: @escaping (Result<Photo, Error>) -> Void)
    -> Cancellable? {
        // 레포지터리의 search or fetch 해오는 기능 호출로 역할 위임
        return nil
    }
}
