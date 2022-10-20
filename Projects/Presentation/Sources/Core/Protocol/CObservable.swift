//
//  CObservable.swift
//  Presentation
//
//  Created by taekki on 2022/10/20.
//  Copyright © 2022 taekki. All rights reserved.
//

import Foundation

final class CObservable<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
