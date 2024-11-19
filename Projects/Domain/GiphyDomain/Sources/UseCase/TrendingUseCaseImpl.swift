import Foundation
import RxSwift
import GiphyDomainInterface

struct TrendingUseCaseImpl: TrendingUseCase {
    
    private let giphyRepository: any GiphyRepository
    
    init(giphyRepository: any GiphyRepository) {
        self.giphyRepository = giphyRepository
    }
    
    func callAsFunction(offset: Int) -> Single<GiphyModel> {
        Single.create { observer in
            let task = Task(priority: .userInitiated) {
                do {
                    try Task.checkCancellation()
                    let model = try await giphyRepository.fetchTrendingGIFs(
                        offset: offset
                    )
                    try Task.checkCancellation()
                    observer(.success(model))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create(with: task.cancel)
        }
    }
}
