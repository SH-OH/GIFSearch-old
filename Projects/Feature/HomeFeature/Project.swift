import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface),
        ]),
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .HomeFeature, type: .interface),
            .domain(target: .GiphyDomain, type: .interface),
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature),
            .domain(target: .GiphyDomain, type: .testing),
        ])
    ]
)
