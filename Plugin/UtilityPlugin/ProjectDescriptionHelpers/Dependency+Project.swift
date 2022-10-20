//
//  Dependency+Project.swift
//  UtilityPlugin
//
//  Created by taekki on 2022/10/20.
//

import ProjectDescription

extension TargetDependency {
    public struct Project {
        public struct Module {}
        public struct Network {}
    }
}

public extension TargetDependency.Project {
    static let Feature = TargetDependency.project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
}

public extension TargetDependency.Project.Module {
    static let ThirdPartyLibraryManager = TargetDependency.project(target: "ThirdPartyLibraryManager", path: .relativeToRoot("Projects/ThirdPartyLibraryManager"))
}

public extension TargetDependency.Project.Network {
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
}
