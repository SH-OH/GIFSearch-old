import Foundation
import GiphyDomainInterface

struct GIFResponseDTO: Decodable {
    let type: String?
    let id: String?
    let url: String?
    let slug: String?
    let bitlyGifUrl: String?
    let bitlyUrl: String?
    let embedUrl: String?
    let username: String?
    let source: String?
    let title: String?
    let rating: String?
    let contentUrl: String?
    let sourceTld: String?
    let sourcePostUrl: String?
    let isSticker: Int?
    let importDatetime: String?
    let trendingDatetime: String?
    let images: [String: ImageResponseDTO]?
}

extension GIFResponseDTO {
    func toDomain() -> GiphyModel.Item {
        return .init(id: id ?? "", images: images?.toDomain() ?? [:])
    }
}

extension [String: ImageResponseDTO] {
    func toDomain() -> [ImageType: ImageModel] {
        reduce(into: [ImageType: ImageModel]()) { result, next in
            guard
                let imageType = ImageType(rawValue: next.key),
                let imageModel = next.value.toDomain()
            else {
                return
            }
            
            result[imageType] = imageModel
        }
    }
}
