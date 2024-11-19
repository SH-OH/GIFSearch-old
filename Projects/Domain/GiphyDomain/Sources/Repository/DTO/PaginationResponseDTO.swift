import Foundation

struct PaginationResponseDTO: Decodable {
    let offset: Int?
    let totalCount: Int?
    let count: Int?
}
