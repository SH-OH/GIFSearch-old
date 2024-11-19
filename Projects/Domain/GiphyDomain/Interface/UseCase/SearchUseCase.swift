import Foundation
import RxSwift

public protocol SearchUseCase {
    func callAsFunction(query: String, offset: Int) -> Single<GiphyModel>
}
