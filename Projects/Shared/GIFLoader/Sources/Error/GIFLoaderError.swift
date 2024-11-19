import Foundation

enum GIFLoaderError: Error {
    case invalidURL
    case invalidResponse
    case invalidData(Error)
    case underlying(Error)
}
