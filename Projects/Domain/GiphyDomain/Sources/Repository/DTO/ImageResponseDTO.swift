import Foundation
import FoundationUtil
import GiphyDomainInterface

struct ImageResponseDTO: Decodable {
    let height: String?
    let width: String?
    let size: String?
    let url: String?
    
    // original only
    let mp4Size: String?
    let mp4: String?
    let webpSize: String?
    let webp: String?
    let frames: String?
    let hash: String?
}

extension ImageResponseDTO {
    func toDomain() -> ImageModel? {
        guard
            let height = height?.cgFloat,
            let width = width?.cgFloat,
            let size = size?.int,
            let url = url?.url
        else {
            return nil
        }
        
        return .init(
            height: height,
            width: width,
            size: size,
            url: url
        )
    }
}
