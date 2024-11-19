import Foundation
import BaseCoreInterface
import NetworkingInterface

final class NetworkingImpl: Networking {
    private enum Const {
        static let timeout: TimeInterval = 30.0
    }
    
    private let session: URLSessionProtocol
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder: JSONDecoder = .init()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(target: TargetType) async throws -> T {
        let data = try await performRequest(target: target)
        return try jsonDecoder.decode(T.self, from: data)
    }
}

private extension NetworkingImpl {
    func performRequest(target: TargetType) async throws -> Data {
        let request: URLRequest = try buildRequest(from: target)
        do {
            let data = try await createDataTask(with: request)
            return data
            
        } catch {
            guard
                case NetworkingError.statusCode(let response) = error,
                let httpResponse = response as? HTTPURLResponse
            else {
                throw NetworkingError.underlying(error)
            }
            
            throw target.errorMap[httpResponse.statusCode] ?? error
        }
    }
    
    func createDataTask(with request: URLRequest) async throws -> Data {
        do {
            let (data, response): (Data, URLResponse) = try await session.data(for: request, delegate: nil)
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode
            else {
                throw NetworkingError.statusCode(response)
            }
            
            return data
            
        } catch {
            throw error
        }
    }
    
    func buildRequest(from target: TargetType) throws -> URLRequest {
        let urlComponents = try configureURLComponents(from: target)
        let request = try configureURLRequest(from: urlComponents, with: target)
        return request
    }
    
    func configureURLComponents(from target: TargetType) throws -> URLComponents {
        guard let url = target.baseURL?.appendingPathComponent(target.apiVersion.rawValue + target.path),
              var urlComponents = URLComponents(string: url.absoluteString) else {
            throw NetworkingError.invalidURL
        }
        
        if let parameters = target.parameters,
           /// .get, .head, .delete
           [HTTPMethod.get].contains(target.method) {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        
        return urlComponents
    }
    
    func configureURLRequest(from urlComponents: URLComponents, with target: TargetType) throws -> URLRequest {
        guard let finalUrl = urlComponents.url else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(
            url: finalUrl,
            cachePolicy: .reloadRevalidatingCacheData,
            timeoutInterval: Const.timeout
        )
        
        request.httpMethod = target.method.rawValue
        
        if let headers = target.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
