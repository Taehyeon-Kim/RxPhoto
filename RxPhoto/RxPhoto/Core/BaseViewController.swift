//
//  BaseViewController.swift
//  RxPhoto
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: - Initialize
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttributes()
        setupConstraints()
        bind()
    }

    // MARK: - Attributes
    func setupAttributes() {}
    
    // MARK: - Constraints
    func setupConstraints() {}
    
    // MARK: - Bind
    func bind() {}
}
