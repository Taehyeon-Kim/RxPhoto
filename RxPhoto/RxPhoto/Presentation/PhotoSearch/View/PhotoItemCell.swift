//
//  PhotoItemCell.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import SnapKit
import Then

final class PhotoItemCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAttributes()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
        }
    }
    
    private func setupConstraints() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PhotoItemCell {
    func configure(imagePath: String) {
        DispatchQueue.global().async {
            let url = URL(string: imagePath)
            let data = try! Data(contentsOf: url!)
            
            DispatchQueue.main.async { [weak self] in
                self?.backgroundImageView.image = UIImage(data: data)
            }
        }
    }
}
