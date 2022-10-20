//
//  ImageSearchViewController.swift
//  Presentation
//
//  Created by taekki on 2022/10/20.
//  Copyright © 2022 taekki. All rights reserved.
//

import UIKit

import Network
import SnapKit
import Then

public class ImageSearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    
    private let viewModel = ImageSearchViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureHierarchy()
        configureDataSource()
        bind()
    }
}

extension ImageSearchViewController {
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
    }
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, item in
            var contentConfig = UIListContentConfiguration.valueCell()
            contentConfig.text = "\(item.likes)"
            cell.contentConfiguration = contentConfig
        }

        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
                return cell
            })
    }
    
    private func bind() {
        viewModel.photoList.bind { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource.apply(snapshot)
        }
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}
