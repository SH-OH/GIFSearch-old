import Foundation

struct MetaResponseDTO: Decodable {
    let msg: String
    let status: Int
    let responseId: String?
}
