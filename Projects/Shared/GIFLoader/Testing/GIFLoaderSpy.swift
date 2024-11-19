import Foundation
import UIKit

//final class GIFLoaderSpy: GIFLoader {
//    var storage: [URL: [UIImage]] = [:]
//    
//    var isCachedCallCount: Int = 0
//    func isCached(for url: URL) -> Bool {
//        isCachedCallCount += 1
//        return storage[url] != nil
//    }
//    
//    var retrieveGIFCallCount: Int = 0
//    var retrieveGIFReturn: [UIImage] = []
//    func retrieveGIF(_ url: URL?) async throws -> [UIImage] {
//        retrieveGIFCallCount += 1
//        if let url {
//            storage[url] = retrieveGIFReturn
//        }
//        return retrieveGIFReturn
//    }
//    
//    var cancelCallCount: Int = 0
//    func cancel(for url: URL) {
//        cancelCallCount += 1
//    }
//}
