import Foundation

enum GiphyResponseError: Int, DomainError {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case uriTooLong = 414
    case tooManyRequests = 429
}

extension GiphyResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Your request was formatted incorrectly or missing a required parameter(s)."
        case .unauthorized:
            return "Your request lacks valid authentication credentials for the target resource, which most likely indicates an issue with your API Key or the API Key is missing."
        case .forbidden:
            return "You weren't authorized to make your request; most likely this indicates an issue with your API Key."
        case .notFound:
            return "The particular GIF or Sticker you are requesting was not found. This occurs, for example, if you request a GIF by using an id that does not exist."
        case .uriTooLong:
            return "The length of the search query exceeds 50 characters."
        case .tooManyRequests:
            return "Your API Key is making too many requests. Read about requesting a Production Key to upgrade your API Key rate limits."
        }
    }
}
