import Foundation

final class MockSessionDataTask: URLSessionDataTask {
    var resumeDidCall = {}
    
    override init() {}
    
    override func resume() {
        resumeDidCall()
    }
}
