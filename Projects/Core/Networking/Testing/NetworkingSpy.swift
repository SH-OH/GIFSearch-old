import Foundation
import NetworkingInterface

final class NetworkingSpy: Networking {
    var requestCallCount: Int = 0
    var requestReturn: (any Decodable) = String()
    func request<T>(target: any TargetType) async throws -> T where T : Decodable {
        requestCallCount += 1
        return requestReturn as! T
    }
}
