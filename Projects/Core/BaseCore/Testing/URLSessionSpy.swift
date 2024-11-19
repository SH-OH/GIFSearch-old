import Foundation
import BaseCoreInterface

final class URLSessionSpy: URLSessionProtocol {
    var dataCallCount: Int = 0
    var dataReturn: (Data, HTTPURLResponse) = (Data(), HTTPURLResponse())
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dataCallCount += 1
        return dataReturn
    }
    
    var dataTaskCallCount: Int = 0
    var dataTaskCompletionHandler: (Data?, URLResponse?, (any Error)?) = (Data(), HTTPURLResponse(), NSError())
    var mockSessionDataTask: MockSessionDataTask?
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        
        let (data, response, error) = dataTaskCompletionHandler
        let sessionDataTask = MockSessionDataTask()
        
        sessionDataTask.resumeDidCall = {
            completionHandler(data, response, error)
        }
        
        self.mockSessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}
