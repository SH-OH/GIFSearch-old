import UIKit
import ImageIO
import BaseCoreInterface
import StdUtil

typealias GIFMemoryStorage = MemoryStorage<NSData>

public final class GIFLoader {
    
    public static let shared: GIFLoader = .init()
    
    private let session: URLSessionProtocol
    private let memoryStorage: GIFMemoryStorage
    
    private let processingQueue: DispatchQueue
    
    private var tasks: [URL: URLSessionDataTask]
    
    init(
        session: URLSessionProtocol,
        memoryStorage: GIFMemoryStorage
    ) {
        self.session = session
        self.memoryStorage = memoryStorage
        self.processingQueue = .init(
            label: "com.GIFLoader.processingQueue",
            qos: .userInitiated,
            attributes: .concurrent
        )
        self.tasks = [:]
    }
    
    convenience init() {
        let memoryStorage: GIFMemoryStorage = .init()
        let configuration = URLSessionConfiguration.ephemeral
        let session: URLSession = .init(configuration: configuration)
        
        self.init(
            session: session,
            memoryStorage: memoryStorage
        )
    }
    
    public func isCached(for url: URL) -> Bool {
        let cacheKey = url.absoluteString
        
        return memoryStorage.isCached(forKey: cacheKey)
    }
    
    @discardableResult
    public func retrieveGIF(_ url: URL?, completionHandler: @escaping (Result<GIFAnimatedImage?, Error>) -> Void) -> URLSessionDataTask? {
        guard let url else { return nil }
        
        func completionHandleOnMainThread(_ result: Result<GIFAnimatedImage?, Error>) {
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        
        let cacheKey = url.absoluteString
        
        if let cachedData = self.memoryStorage.value(forKey: cacheKey) {
            processingQueue.async {
                guard let gifImage = GIFAnimatedImage(data: cachedData as Data) else {
                    completionHandleOnMainThread(.success(nil))
                    return
                }
                
                completionHandleOnMainThread((.success(gifImage)))
            }
        }
        
        let task = createDataTask(from: url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.memoryStorage.store(data as NSData, forKey: cacheKey, cost: data.count)
                
                self.processingQueue.async {
                    guard let gifImage = GIFAnimatedImage(data: data) else {
                        completionHandleOnMainThread(.success(nil))
                        return
                    }
                    
                    completionHandleOnMainThread(.success(gifImage))
                }
                
            case .failure(let error):
                completionHandleOnMainThread(.failure(error))
            }
        }
        
        tasks[url] = task
        
        return task
    }
    
    public func cancel(for url: URL) {
        tasks[url]?.cancel()
        tasks[url] = nil
    }
}

// MARK: - private Helper For Networking

private extension GIFLoader {
    @discardableResult
    func createDataTask(from url: URL, completionHandler: @escaping (Result<(Data), Error>) -> Void) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error {
                completionHandler(.failure(error))
            } else if let data, let response {
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                    completionHandler(.failure(GIFLoaderError.invalidResponse))
                    return
                }
                
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(URLError(.badServerResponse)))
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}
