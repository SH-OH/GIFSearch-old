import XCTest
@testable import GiphyDomainInterface
@testable import GiphyDomain
@testable import NetworkingTesting

final class GiphyRepositoryTests: XCTestCase {
    var networking: NetworkingSpy!
    var sut: GiphyRepositoryImpl!
    
    override func setUpWithError() throws {
        networking = .init()
        sut = .init(networking: networking)
    }

    override func tearDownWithError() throws {
        sut = nil
        networking = nil
    }

    func test_fetchTrendingGIFs() async throws {
        // given
        let expectedUrl = "https://www.google.com"
        let expectedModel = ImageModel(
            height: 0,
            width: 0,
            size: 0,
            url: expectedUrl.url
        )
        let responseDto: GiphyResponseModelDTO<[GIFResponseDTO]> = .init(
            data: [.mock(type: .fixedWidth, imageModel: expectedModel)],
            meta: nil,
            pagination: nil
        )
        networking.requestReturn = responseDto
        XCTAssertEqual(networking.requestCallCount, 0)
        
        // when
        let expectedResult = try await sut.fetchTrendingGIFs(offset: 0)
        
        // then
        XCTAssertEqual(networking.requestCallCount, 1)
        XCTAssertEqual(expectedResult.models.first!.url!, expectedModel.url!)
    }
    
    func test_fetchSearchGIFs() async throws {
        // given
        let expectedUrl = "https://www.google.com"
        let expectedModel = ImageModel(
            height: 0,
            width: 0,
            size: 0,
            url: expectedUrl.url
        )
        let responseDto: GiphyResponseModelDTO<[GIFResponseDTO]> = .init(
            data: [.mock(type: .downsized, imageModel: expectedModel)],
            meta: nil,
            pagination: nil
        )
        networking.requestReturn = responseDto
        XCTAssertEqual(networking.requestCallCount, 0)
        
        // when
        let expectedResult = try await sut.fetchSearchGIFs(query: "test", offset: 0)
        
        // then
        XCTAssertEqual(networking.requestCallCount, 1)
        XCTAssertEqual(expectedResult.models.first!.url!, expectedModel.url!)
    }
}

private extension GIFResponseDTO {
    static func mock(type: ImageType, imageModel: ImageModel) -> Self {
        .init(
            type: nil,
            id: nil,
            url: nil,
            slug: nil,
            bitlyGifUrl: nil,
            bitlyUrl: nil,
            embedUrl: nil,
            username: nil,
            source: nil,
            title: nil,
            rating: nil,
            contentUrl: nil,
            sourceTld: nil,
            sourcePostUrl: nil,
            isSticker: nil,
            importDatetime: nil,
            trendingDatetime: nil,
            images: [
                type.rawValue: .init(
                    height: imageModel.height.string,
                    width: imageModel.width.string,
                    size: imageModel.size.string,
                    url: imageModel.url?.absoluteString,
                    mp4Size: nil,
                    mp4: nil,
                    webpSize: nil,
                    webp: nil,
                    frames: nil,
                    hash: nil
                )
            ]
        )
    }
}

private extension Int {
    var string: String {
        String(self)
    }
}

private extension CGFloat {
    var string: String {
        String(Double(self))
    }
}
