import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Networking.rawValue,
    targets: [
        .interface(
            module: .core(.Networking),
            spec: .init(
                infoPlist: .extendingDefault(with: [
                    "BASE_URL": "$(BASE_URL)",
                    "GIPHY_APIKEY": "$(GIPHY_APIKEY)",
                ]),
                dependencies: [
                    .core(target: .BaseCore, type: .interface),
                ]
            )
        ),
        .implements(module: .core(.Networking), dependencies: [
            .core(target: .BaseCore),
            .core(target: .Networking, type: .interface),
        ]),
        .testing(module: .core(.Networking), dependencies: [
            .core(target: .Networking, type: .interface)
        ]),
        .tests(module: .core(.Networking), dependencies: [
            .core(target: .BaseCore, type: .testing),
            .core(target: .Networking, type: .testing),
            .core(target: .Networking)
        ])
    ]
)
