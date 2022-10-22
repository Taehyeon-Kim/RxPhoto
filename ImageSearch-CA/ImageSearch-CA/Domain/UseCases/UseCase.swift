//
//  UseCase.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import Foundation
import Combine

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
