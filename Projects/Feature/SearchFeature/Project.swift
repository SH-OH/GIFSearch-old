import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SearchFeature.rawValue,
    targets: [
        .interface(module: .feature(.SearchFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface),
        ]),
        .implements(module: .feature(.SearchFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SearchFeature, type: .interface),
            .domain(target: .GiphyDomain, type: .interface),
        ]),
        .demo(module: .feature(.SearchFeature), dependencies: [
            .feature(target: .SearchFeature),
            .domain(target: .GiphyDomain, type: .testing),
        ])
    ]
)
