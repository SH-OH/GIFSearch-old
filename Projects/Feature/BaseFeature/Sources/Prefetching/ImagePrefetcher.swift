import Foundation
import FoundationUtil
import StdUtil
import GIFLoader

public final class ImagePrefetcher {
    
    private var tasks: [URL: URLSessionDataTask]
    
    public init(
        tasks: [URL: URLSessionDataTask] = [:]
    ) {
        self.tasks = tasks
    }
    
    public func prefetchRows(with items: [some ImagePrefetchable], at indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let imageUrl = items[safe: indexPath.item]?.url else { return }
            guard self.tasks[imageUrl] == nil else { return }
            
            guard !GIFLoader.shared.isCached(for: imageUrl) else { return }
            
            self.startPrefetchImage(imageUrl)
        }
    }
    
    public func cancelPrefetchRows(with items: [some ImagePrefetchable], at indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let imageUrl = items[safe: indexPath.row]?.url else { return }
            guard self.tasks[imageUrl] != nil else { return }
            
            self.cancelPrefetchImage(imageUrl)
        }
    }
}

// MARK: - Prefetching

private extension ImagePrefetcher {
    func startPrefetchImage(_ imageUrl: URL) {
        self.tasks[imageUrl] = GIFLoader.shared.retrieveGIF(imageUrl) { _ in }
    }
    
    func cancelPrefetchImage(_ imageUrl: URL) {
        tasks[imageUrl]?.cancel()
        tasks[imageUrl] = nil
    }
    
    func resetPrefetchedUrls() {
        tasks.removeAll(keepingCapacity: true)
    }
}
