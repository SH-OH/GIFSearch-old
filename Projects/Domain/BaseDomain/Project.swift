import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .interface(module: .domain(.BaseDomain), dependencies: [
            
        ]),
        .implements(module: .domain(.BaseDomain), product: .framework, dependencies: [
            .shared(target: .GlobalThirdPartyLibrary),
            .core(target: .Networking, type: .interface),
        ]),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ])
    ]
)
