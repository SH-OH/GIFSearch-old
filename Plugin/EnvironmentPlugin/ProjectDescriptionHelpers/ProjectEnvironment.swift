import Foundation
@preconcurrency import ProjectDescription

public struct ProjectEnvironment: Sendable {
    public let name: String
    public let organizationName: String
    public let destinations: Destinations
    public let deploymentTargets: DeploymentTargets
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    name: "GIFSearch",
    organizationName: "com-SHOH",
    destinations: [.iPhone],
    deploymentTargets: .iOS("15.0"),
    baseSetting: [:]
)
