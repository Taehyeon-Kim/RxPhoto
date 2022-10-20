//
//  ConfigurationName+Extension.swift
//  UtilityPlugin
//
//  Created by taekki on 2022/10/20.
//

import Foundation
import ProjectDescription

public extension ConfigurationName {
    static var dev: ConfigurationName { configuration(ProjectDeployTarget.dev.rawValue) }
    static var test: ConfigurationName { configuration(ProjectDeployTarget.test.rawValue) }
    static var prod: ConfigurationName { configuration(ProjectDeployTarget.prod.rawValue) }
}
