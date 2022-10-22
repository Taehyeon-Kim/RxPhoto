//
//  SearchPhotoViewController.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import UIKit

import Kingfisher
import RxSwift
import SnapKit
import Then

final class SearchPhotoViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.generateLayout()
    )
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    private let disposeBag = DisposeBag()
    private let viewModel: SearchPhotoViewModel
    
    init(viewModel: SearchPhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureLayout()
        configureDataSource()
        bind()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        
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
    
    private func bind() {
        viewModel.items.subscribe { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo)
            self.dataSource.apply(snapshot)
        }.disposed(by: disposeBag)
    }
}

extension SearchPhotoViewController {
    
    private func generateLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Photo> { cell, indexPath, item in
            var content = UIListContentConfiguration.cell()
            
            DispatchQueue.global().async {
                let path = URL(string: item.imagePath ?? "")!
                let data = try! Data(contentsOf: path)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data)
                    cell.contentConfiguration = content
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
                return cell
            })
    }
}

extension SearchPhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        viewModel.load(query: keyword)
    }
}
