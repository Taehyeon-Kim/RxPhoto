//
//  PhotoDetailViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

final class PhotoDetailViewController: BaseViewController {
    
    private let viewModel: PhotoDetailViewModel
    
    private let backgroundImageView = UIImageView()
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupAttributes() {
        self.do {
            $0.view.backgroundColor = .systemBackground
        }
    }
    
    override func setupConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        viewModel.fetchSinglePhoto()
        
        viewModel.photo
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, photo in
                vc.backgroundImageView.kf.indicatorType = .activity
                vc.backgroundImageView.kf.setImage(with: photo.imageURL)
            }
            .disposed(by: disposeBag)
    }
}
