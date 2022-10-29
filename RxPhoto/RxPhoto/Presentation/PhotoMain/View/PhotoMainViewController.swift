//
//  PhotoMainViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import UIKit

import RxCocoa

final class PhotoMainViewController: BaseViewController {
    
    private let viewModel = PhotoMainViewModel(
        provider: ProviderImpl()
    )
    
    private let searchBarButtonItem = UIBarButtonItem(systemItem: .search)
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupAttributes() {
        self.do {
            $0.view.backgroundColor = .systemBackground
            $0.navigationController?.navigationBar.prefersLargeTitles = true
            $0.navigationController?.navigationBar.tintColor = .black
            $0.navigationItem.rightBarButtonItems = [searchBarButtonItem]
        }
        
        collectionView.do {
            $0.register(PhotoItemCell.self, forCellWithReuseIdentifier: "PhotoItemCell")
        }
    }
    
    override func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        viewModel.fetchPhotos()
        
        viewModel.navigationTitle
            .asDriver()
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        searchBarButtonItem.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigateToPhotoSearch()
            }
            .disposed(by: disposeBag)
        
        viewModel.photos
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "PhotoItemCell", cellType: PhotoItemCell.self)) { row, element, cell in
                cell.backgroundImageView.kf.indicatorType = .activity
                cell.backgroundImageView.kf.setImage(with: element.imageURL)
            }
            .disposed(by: disposeBag)
    }
}

extension PhotoMainViewController {
    private func navigateToPhotoSearch() {
        let viewController = PhotoSearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PhotoMainViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(220)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
