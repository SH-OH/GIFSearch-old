import XCTest
import RxSwift
@testable import GiphyDomainInterface
@testable import GiphyDomain
@testable import GiphyDomainTesting

final class TrendingUseCaseTests: XCTestCase {
    var giphyRepository: GiphyRepositorySpy!
    var sut: TrendingUseCaseImpl!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        disposeBag = .init()
        giphyRepository = .init()
        sut = .init(giphyRepository: giphyRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        giphyRepository = nil
        disposeBag = nil
    }
    
    func test_callAsFunction() throws {
        // given
        let expectedTotalCount = 3
        let expectation: XCTestExpectation = .init(description: #function)
        let expectedImages: [ImageModel] = (0..<3).map({ index in
            let value = index + 1
            return .init(
                height: CGFloat(value),
                width: CGFloat(value),
                size: value,
                url: nil
            )
        })
        giphyRepository.fetchTrendingGIFsReturn = GiphyModel(totalCount: expectedTotalCount, models: expectedImages)
        XCTAssertEqual(giphyRepository.fetchTrendingGIFsCallCount, 0)
        
        // when
        var receivedTotal: Int!
        var receivedImages: [ImageModel]!
        sut(offset: 0)
            .subscribe(onSuccess: { result in
                receivedTotal = result.totalCount
                receivedImages = result.models
            }, onFailure: { error in
                XCTFail("This test must always be successful. error is \(error)")
            }, onDisposed: {
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(giphyRepository.fetchTrendingGIFsCallCount, 1)
        XCTAssertEqual(receivedTotal, expectedTotalCount)
        XCTAssertEqual(receivedImages, expectedImages)
    }
}
