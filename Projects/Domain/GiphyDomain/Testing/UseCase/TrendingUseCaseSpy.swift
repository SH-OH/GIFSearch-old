import Foundation
import RxSwift
import GiphyDomainInterface

final class TrendingUseCaseSpy: TrendingUseCase {
    var callAsFunctionCallCount: Int = 0
    var callAsFunctionReturn: GiphyDomainInterface.GiphyModel!
    func callAsFunction(offset: Int) -> RxSwift.Single<GiphyDomainInterface.GiphyModel> {
        callAsFunctionCallCount += 1
        return .just(callAsFunctionReturn)
            .delay(.seconds(1), scheduler: MainScheduler.instance)
    }
}
