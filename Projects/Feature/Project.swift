//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by taekki on 2022/10/20.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "Feature",
    product: .staticFramework,
    dependencies: [
        .Project.Network.Network
    ],
    resources: ["Resources/**"]
)
