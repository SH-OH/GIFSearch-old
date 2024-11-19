import Foundation
import GiphyDomainInterface

final class GiphyRepositorySpy: GiphyRepository {
    var fetchTrendingGIFsCallCount: Int = 0
    var fetchTrendingGIFsReturn: GiphyDomainInterface.GiphyModel!
    func fetchTrendingGIFs(offset: Int) async throws -> GiphyDomainInterface.GiphyModel {
        fetchTrendingGIFsCallCount += 1
        return fetchTrendingGIFsReturn
    }
    
    var fetchSearchGIFsCallCount: Int = 0
    var fetchSearchGIFsReturn: GiphyDomainInterface.GiphyModel!
    func fetchSearchGIFs(query: String, offset: Int) async throws -> GiphyDomainInterface.GiphyModel {
        fetchSearchGIFsCallCount += 1
        return fetchSearchGIFsReturn
    }
}
