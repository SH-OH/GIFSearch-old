import Foundation
import RxSwift

public protocol TrendingUseCase {
    func callAsFunction(offset: Int) -> Single<GiphyModel>
}
