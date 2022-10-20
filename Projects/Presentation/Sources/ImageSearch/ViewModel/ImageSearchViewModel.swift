//
//  ImageSearchViewModel.swift
//  Presentation
//
//  Created by taekki on 2022/10/20.
//  Copyright © 2022 taekki. All rights reserved.
//

import Foundation

import Network

final class ImageSearchViewModel {
    
    var photoList: CObservable<SearchPhotoDTO> = CObservable(SearchPhotoDTO.empty())
    
    func requestSearchPhoto(query: String) {
        ImageService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo else { return }
            self.photoList.value = photo
        }
    }
}
