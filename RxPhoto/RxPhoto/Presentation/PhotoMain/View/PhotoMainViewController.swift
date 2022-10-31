//
//  PhotoMainViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/29.
//

import UIKit

import RxCocoa

final class PhotoMainViewController: BaseViewController {
    
    private let viewModel: PhotoMainViewModel = PhotoMainViewModelImpl()
    
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
        // fetch 해온 데이터만 Relay에 다시 넣는 것이 맞을까?
        // subscribe 부분에서 collectionView 세팅해주면 안되는건가?
        viewModel.fetchPhotos()
            .subscribe { photos in
                self.viewModel.photos.accept(photos)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)

        let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: 2)
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: 3)
        
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1000))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [leadingGroup, trailingGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
