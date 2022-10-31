//
//  PhotoSearchViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift
import Kingfisher

final class PhotoSearchViewController: BaseViewController {
    
    private var viewModel: PhotoSearchViewModel = PhotoSearchViewModelImpl()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    // MARK: - UI
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Overriding Functions
    
    override func setupAttributes() {
        self.do {
            $0.view.backgroundColor = .systemBackground
            $0.navigationController?.navigationBar.prefersLargeTitles = true
            $0.searchBar.backgroundImage = UIImage()
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    override func setupConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        configureDataSource()
        
        viewModel.navigationTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.photos
            .withUnretained(self)
            .bind { vc, photos in
                var snapshot = vc.dataSource.snapshot()
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([0])
                }
                snapshot.appendItems(photos)
                vc.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive { query in
                self.viewModel.search(with: query)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .asDriver()
            .drive { [weak self] indexPath in
                guard let self = self else { return }
                let id = self.viewModel.photos.value[indexPath.item].id
                self.navigateToPhotoDetail(id: id)
            }
            .disposed(by: disposeBag)
    }
    
    private func navigateToPhotoDetail(id: String) {
        let viewModel = PhotoDetailViewModelImpl(id: id)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        present(viewController, animated: true)
    }
}

extension PhotoSearchViewController {
    
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
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PhotoItemCell, Photo> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = .systemGray5
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            cell.backgroundImageView.kf.indicatorType = .activity
            cell.backgroundImageView.kf.setImage(with: item.imageURL)
            return cell
        })
    }
}
