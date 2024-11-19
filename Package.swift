// swift-tools-version:6.0
@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSetting = PackageSettings(
    baseSettings: .settings(
        configurations: [
            .debug(name: .dev),
            .debug(name: .stage),
            .release(name: .prod)
        ]
    )
)
#endif

let package = Package(
    name: "KakaoHairshop-iOS-OHSANGHO",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.7.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
    ],
    targets: [
        .target(name: "RxProject", dependencies: [
            "RxSwift",
            .product(name: "RxCocoa", package: "RxSwift"),
            .product(name: "RxRelay", package: "RxSwift"),
        ])
    ]
)
