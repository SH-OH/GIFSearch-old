import Foundation

enum NetworkingError: Error {
    case invalidURL
    case statusCode(URLResponse)
    case underlying(Error)
}

extension NetworkingError {
    var response: URLResponse? {
        switch self {
        case let .statusCode(response):
            return response
        default:
            return nil
        }
    }
}
