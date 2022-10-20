//
//  ProjectDeployTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by taekki on 2022/10/20.
//

import Foundation
import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "DEV"
    case test = "TEST"
    case prod = "PROD"
    
    public var configurationName: ConfigurationName {
        ConfigurationName.configuration(self.rawValue)
    }
}
