import XCTest
@testable import BaseCoreTesting
@testable import NetworkingInterface
@testable import Networking
@testable import NetworkingTesting

final class NetworkingTests: XCTestCase {
    var session: URLSessionSpy!
    var sut: NetworkingImpl!
    
    override func setUpWithError() throws {
        session = .init()
        sut = .init(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        session = nil
    }

    func test_requestSucceedsWithStatusCode200() async throws {
        // given
        let target = TestTarget.getTest
        let testUrl: URL = target.baseURL!.appendingPathComponent(target.apiVersion.rawValue + target.path)
        let response: HTTPURLResponse = .init(
            url: testUrl,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let expectedString: String = "request_test"
        session.dataReturn = (try JSONEncoder().encode(expectedString), response)
        XCTAssertEqual(session.dataCallCount, 0)
        
        // when
        let result: String = try await sut.request(target: TestTarget.getTest)
        
        // then
        XCTAssertEqual(session.dataCallCount, 1)
        XCTAssertEqual(result, expectedString)
    }
    
    func test_requestFailsWithStatusCode400() async throws {
        // given
        let target = TestTarget.getTest
        let testUrl: URL = target.baseURL!.appendingPathComponent(target.apiVersion.rawValue + target.path)
        let response: HTTPURLResponse = .init(
            url: testUrl,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        let testString: String = "request_test"
        session.dataReturn = (try JSONEncoder().encode(testString), response)
        XCTAssertEqual(session.dataCallCount, 0)
        
        // when
        do {
            let _: String = try await sut.request(target: TestTarget.getTest)
            XCTFail("This request must always fail.")
        } catch {
            let response = (error as! NetworkingError).response
            let statusCode = (response as! HTTPURLResponse).statusCode
            XCTAssertEqual(statusCode, 400)
        }
        
        // then
        XCTAssertEqual(session.dataCallCount, 1)
    }
}
