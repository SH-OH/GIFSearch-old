import Foundation
import NetworkingInterface

enum TestTarget {
    case getTest
}

extension TestTarget: TargetType {
    var path: String { "/gifs/trending" }
    var method: NetworkingInterface.HTTPMethod { .get }
    var parameters: NetworkingInterface.Parameters? { nil }
    var headers: NetworkingInterface.Headers? { nil }
}
