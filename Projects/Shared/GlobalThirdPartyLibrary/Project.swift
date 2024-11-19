import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    targets: [
        .implements(module: .shared(.GlobalThirdPartyLibrary), product: .framework, dependencies: [
            .SPM.Swinject,
            .SPM.RxSwift,
            .SPM.RxRelay,
            .SPM.RxCocoa,
            .shared(target: .FoundationUtil),
            .shared(target: .StdUtil),
        ])
    ]
)
