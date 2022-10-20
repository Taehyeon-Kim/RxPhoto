import Foundation
import ProjectDescription

// MARK: - Extension
extension TargetDependency {
    public struct SPM {
        public struct DevelopTool {}
        public struct UserInterface {}
    }
}
extension Package {
    public struct DevelopTool {}
    public struct UserInterface {}
}

// MARK: - Network
public extension TargetDependency.SPM {
    static let Kingfisher = TargetDependency.swiftPackageManager(name: "Kingfisher")
    static let Moya = TargetDependency.package(product: "Moya")
    static let Alamofire = TargetDependency.package(product: "Alamofire")
}

// MARK: - Rx
public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxRelay = TargetDependency.package(product: "RxRelay")
}

// MARK: - Layout
public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.swiftPackageManager(name: "SnapKit")
}

// MARK: - Others
public extension TargetDependency.SPM {
    static let Then = TargetDependency.swiftPackageManager(name: "Then")
    static let Reusable = TargetDependency.swiftPackageManager(name: "Reusable")
}

public extension Package {
    static let SnapKit = Package.package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    static let Kingfisher = Package.package(url: "https://github.com/onevcat/Kingfisher.git", .branch("master"))
    static let Then = Package.package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "2.7.0"))
    static let Reusable = Package.package(url: "https://github.com/AliSoftware/Reusable.git", .upToNextMajor(from: "4.1.2"))
    
    static let RxSwift = Package.package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.2.0"))
    static let RxSwiftExt = Package.package(url: "https://github.com/RxSwiftCommunity/RxSwiftExt.git", .branch("main"))
    static let Alamofire = Package.package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0"))
    static let Moya = Package.package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
}

public extension TargetDependency {
    static func swiftPackageManager(name: String) -> Self {
        TargetDependency.package(product: name)
    }
}
