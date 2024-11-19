import RxSwift
import RxCocoa

public extension ObservableConvertibleType {
    func asDriverWithEmpty() -> Driver<Element> {
        asDriver(onErrorDriveWith: .empty())
    }
}
