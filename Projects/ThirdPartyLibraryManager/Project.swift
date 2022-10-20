//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by taekki on 2022/10/20.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLibraryManager",
    product: .framework,
    packages: [
        .Moya,
        .SnapKit,
        .Then,
        .Kingfisher,
        .Reusable
    ],
    dependencies: [
        .SPM.Moya,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.Kingfisher,
        .SPM.Reusable
    ].compactMap { $0 }
)
