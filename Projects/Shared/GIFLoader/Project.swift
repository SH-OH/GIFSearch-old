import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.GIFLoader.rawValue,
    targets: [
        .implements(module: .shared(.GIFLoader), dependencies: [
            .shared(target: .StdUtil),
            .core(target: .BaseCore, type: .interface),
        ]),
        .testing(module: .shared(.GIFLoader), dependencies: [
            .shared(target: .GIFLoader)
        ]),
        .tests(module: .shared(.GIFLoader), dependencies: [
            .shared(target: .GIFLoader, type: .testing),
            .core(target: .BaseCore, type: .testing),
        ])
    ]
)
