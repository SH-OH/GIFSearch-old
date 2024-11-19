import Foundation
import GiphyDomainInterface
import NetworkingInterface

final class GiphyRepositoryImpl: GiphyRepository {
    
    private let networking: any Networking
    private lazy var apiKey: String = Bundle.networking.infoDictionary?["GIPHY_APIKEY"] as? String ?? ""
    
    init(networking: any Networking) {
        self.networking = networking
    }
    
    func fetchTrendingGIFs(offset: Int) async throws -> GiphyModel {
        let dto: GiphyResponseModelDTO<[GIFResponseDTO]> = try await networking.request(
            target: GiphyTarget.getTrending(
                apiKey: apiKey,
                limit: 50,
                offset: offset,
                rating: "r"
            )
        )
        
        let totalCount = dto.pagination?.totalCount ?? 0
        let items = dto.data?.compactMap({ $0.toDomain().images[.fixedWidth] }) ?? []
        
        return .init(totalCount: totalCount, models: items)
    }
    
    func fetchSearchGIFs(query: String, offset: Int) async throws -> GiphyModel {
        let dto: GiphyResponseModelDTO<[GIFResponseDTO]> = try await networking.request(
            target: GiphyTarget.getSearch(
                apiKey: apiKey,
                query: query,
                limit: 50,
                offset: offset,
                rating: "r",
                language: "ko"
            )
        )
        
        let totalCount = dto.pagination?.totalCount ?? 0
        let items = dto.data?.compactMap({ $0.toDomain().images[.downsized] }) ?? []
        
        return .init(totalCount: totalCount, models: items)
    }
}
