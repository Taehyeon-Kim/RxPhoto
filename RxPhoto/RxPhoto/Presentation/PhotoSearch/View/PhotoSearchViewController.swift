//
//  PhotoSearchViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import RxCocoa
import RxSwift

final class PhotoSearchViewController: UIViewController {
    
    private let rootView = PhotoSearchView()
    private let viewModel = PhotoSearchViewModel()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PhotoSearchViewController {
    
}
