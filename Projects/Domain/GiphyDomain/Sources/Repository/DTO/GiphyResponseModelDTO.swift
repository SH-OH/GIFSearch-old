import Foundation

struct GiphyResponseModelDTO<T: Decodable>: Decodable {
    let data: T?
    let meta: MetaResponseDTO?
    let pagination: PaginationResponseDTO?
}
