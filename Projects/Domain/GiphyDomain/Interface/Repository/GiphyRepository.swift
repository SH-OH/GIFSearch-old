import Foundation

public protocol GiphyRepository {
    func fetchTrendingGIFs(offset: Int) async throws -> GiphyModel
    func fetchSearchGIFs(query: String, offset: Int) async throws -> GiphyModel
}
