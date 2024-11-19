import Foundation

public protocol Networking {
    func request<T: Decodable>(target: TargetType) async throws -> T
}
