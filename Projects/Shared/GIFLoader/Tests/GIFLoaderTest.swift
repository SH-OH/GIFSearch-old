import XCTest
@testable import BaseCoreTesting
@testable import GIFLoader

final class GIFLoaderTests: XCTestCase {
    var session: URLSessionSpy!
    var memoryStorage: GIFMemoryStorage!
    var sut: GIFLoader!
    
    override func setUpWithError() throws {
        session = .init()
        memoryStorage = GIFMemoryStorage()
        sut = .init(
            session: session,
            memoryStorage: memoryStorage
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        memoryStorage = nil
        session = nil
    }
    
    func test_retrieveGIFSucceeds() throws {
        // given
        let expectation = XCTestExpectation(description: #function)
        let testUrl: URL = URL(string: "https://media1.giphy.com/media/qpozeUvfqwmgu8l6Sc/giphy.gif?cid=72ae528fighodsfa1i5pi3j4beaj5tmr6tu6lew6qq529xq0&ep=v1_gifs_trending&rid=giphy.gif&ct=g")!
        let response: HTTPURLResponse = .init(
            url: testUrl,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let testGIFData = try testUrl.toData()
        session.dataTaskCompletionHandler = (testGIFData, response, nil)
        XCTAssertEqual(session.dataTaskCallCount, 0)
        
        // when
        var expectedResult: GIFAnimatedImage!
        sut.retrieveGIF(testUrl, completionHandler: { result in
            switch result {
            case .success(let success):
                expectedResult = success
            case .failure(let error):
                XCTFail("This test must always be successful. error is \(error)")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 3)
        
        // then
        XCTAssertEqual(session.dataTaskCallCount, 1)
        XCTAssertNotEqual(expectedResult.images, [])
    }
    
    func test_createGIFImage() throws {
        // given
        let testUrl: URL = URL(string: "https://media1.giphy.com/media/qpozeUvfqwmgu8l6Sc/giphy.gif?cid=72ae528fighodsfa1i5pi3j4beaj5tmr6tu6lew6qq529xq0&ep=v1_gifs_trending&rid=giphy.gif&ct=g")!
        let testGIFData = try testUrl.toData()
        
        // when
        let gifImage = GIFAnimatedImage(data: testGIFData)!
        
        // then
        XCTAssertNotEqual(gifImage.images, [])
    }
}

extension URL {
    func toData() throws -> Data {
        try Data(contentsOf: self)
    }
}
