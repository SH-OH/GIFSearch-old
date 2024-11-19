import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .interface(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface),
        ]),
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .MainTabFeature, type: .interface),
            .feature(target: .HomeFeature, type: .interface),
            .feature(target: .SearchFeature, type: .interface),
        ])
    ]
)
