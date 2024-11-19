import Foundation
import RxRelay

public extension BehaviorRelay where Element == [FetchType: Bool] {
    func update(_ value: Bool, forKey key: Element.Key) {
        var dic = self.value
        dic[key] = value
        self.accept(dic)
    }
}
