import Foundation
import FoundationUtil

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public protocol TargetType {
    var baseURL: URL? { get }
    var apiVersion: APIVersion { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: Headers? { get }
    var errorMap: [Int: Error] { get }
}

public extension TargetType {
    var baseURL: URL? {
        guard let baseURLString = Bundle.networking.infoDictionary?["BASE_URL"] as? String else {
            preconditionFailure("BASE_URL must be set.")
        }
        
        return URL(string: baseURLString)
    }
    var apiVersion: APIVersion { .v1 }
    var errorMap: [Int: Error] { [:] }
}
