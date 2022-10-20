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
    name: "ImageSearch",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.Presentation
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Supports/Info.plist")
)
