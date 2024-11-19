import Foundation

public actor ThreadSafeSet<Element: Hashable> {
    private var set: Set<Element>
    
    public init(set: Set<Element> = .init()) {
        self.set = set
    }
    
    public func insert(_ element: Element) {
        set.insert(element)
    }
    
    public func remove(_ element: Element) {
        set.remove(element)
    }
    
    public func removeAll(keepingCapacity: Bool = false) {
        set.removeAll(keepingCapacity: keepingCapacity)
    }
    
    public func contains(_ element: Element) -> Bool {
        return set.contains(element)
    }
    
    public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        return try set.first(where: predicate)
    }
}
