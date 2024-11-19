import Foundation

private class NetworkingBundleFinder {}

public extension Bundle {
    static let networking = Bundle(for: NetworkingBundleFinder.self)
}
