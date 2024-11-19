import Foundation
import NetworkingInterface

enum GiphyTarget {
    case getTrending(
        apiKey: String,
        limit: Int,
        offset: Int,
        rating: String
    )
    case getSearch(
        apiKey: String,
        query: String,
        limit: Int,
        offset: Int,
        rating: String,
        language: String
    )
}

extension GiphyTarget: TargetType {
    var path: String {
        switch self {
        case .getTrending:
            return "/gifs/trending"
        case .getSearch:
            return "/gifs/search"
        }
    }
    
    var method: NetworkingInterface.HTTPMethod {
        switch self {
        case .getTrending, .getSearch:
            return .get
        }
    }
    
    var parameters: NetworkingInterface.Parameters? {
        switch self {
        case let .getTrending(apiKey, limit, offset, rating):
            return [
                "api_key": apiKey,
                "limit": limit,
                "offset": offset,
                "rating": rating,
            ]
            
        case let .getSearch(apiKey, query, limit, offset, rating, language):
            return [
                "api_key": apiKey,
                "q": query,
                "limit": limit,
                "offset": offset,
                "rating": rating,
                "lang": language,
            ]
        }
    }
    
    var headers: NetworkingInterface.Headers? {
        nil
    }
    
    var errorMap: [Int : any Error] {
        GiphyResponseError.toErrorMap()
    }
}
