import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.BaseCore.rawValue,
    targets: [
        .interface(module: .core(.BaseCore)),
        .implements(module: .core(.BaseCore), product: .framework, dependencies: [
            .shared(target: .GlobalThirdPartyLibrary),
        ]),
        .testing(module: .core(.BaseCore), dependencies: [
            .core(target: .BaseCore, type: .interface)
        ])
    ]
)
