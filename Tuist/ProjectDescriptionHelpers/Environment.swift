import ProjectDescription
import ProjectDescriptionHelpers

/// Environment
///
/// 프로젝트 정보에 대한 정보를 담고 있는 namespace
public enum Environment {
    public static let appName = "ImageSearch"
    public static let targetName = "ImageSearch"
    public static let organizationName = "taekki"
    public static let bundleId = "taekki.image-search"
    public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)
    public static let deploymentDemoTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)
    public static let platform: Platform = .iOS
    
    public static let baseSetting: SettingsDictionary = [
        "CODE_SIGN_IDENTITY": "",
        "CODE_SIGNING_REQUIRED": "NO"
    ]
    
    public static let infoPlist: [String: InfoPlist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "CFBundleDisplayName": "MyApp",
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleVersion": "1"
    ]
}
