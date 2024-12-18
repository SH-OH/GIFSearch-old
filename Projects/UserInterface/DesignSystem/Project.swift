import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.UserInterface.DesignSystem.rawValue,
    targets: [
        .implements(module: .userInterface(.DesignSystem), product: .framework, dependencies: [
            .SPM.SnapKit,
            .shared(target: .GIFLoader),
            .shared(target: .UIKitUtil),
        ]),
        .demo(module: .userInterface(.DesignSystem), dependencies: [
            .userInterface(target: .DesignSystem)
        ])
    ]
)
