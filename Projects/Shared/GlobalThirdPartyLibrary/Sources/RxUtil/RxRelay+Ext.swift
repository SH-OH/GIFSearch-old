import Foundation
import RxRelay

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(_ event: Element) {
        self.accept(self.value + event)
    }
}
