import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.StdUtil.rawValue,
    targets: [
        .implements(module: .shared(.StdUtil), product: .framework)
    ]
)
