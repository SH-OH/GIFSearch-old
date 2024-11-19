import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.GiphyDomain.rawValue,
    targets: [
        .interface(module: .domain(.GiphyDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface),
        ]),
        .implements(module: .domain(.GiphyDomain), dependencies: [
            .domain(target: .BaseDomain),
            .domain(target: .GiphyDomain, type: .interface),
        ]),
        .testing(module: .domain(.GiphyDomain), dependencies: [
            .domain(target: .GiphyDomain, type: .interface)
        ]),
        .tests(module: .domain(.GiphyDomain), dependencies: [
            .domain(target: .GiphyDomain),
            .domain(target: .GiphyDomain, type: .testing),
            .core(target: .Networking, type: .testing),
        ])
    ]
)
