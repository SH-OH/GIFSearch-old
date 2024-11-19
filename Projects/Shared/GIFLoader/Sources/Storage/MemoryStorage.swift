import Foundation

class MemoryStorage<Value: AnyObject> {
    
    private let storage = NSCache<NSString, Value>()
    
    /// - Parameters:
    ///   - countLimit: Default countLimit is 100.
    ///   - totalCostLimit: Default totalCostLimit is 200MB
    init(
        countLimit: Int = 100,
        totalCostLimit: Int = 1024 * 1024 * 200
    ) {
        storage.countLimit = countLimit
        storage.totalCostLimit = totalCostLimit
    }
    
    func isCached(forKey key: String) -> Bool {
        value(forKey: key) != nil
    }
    
    func store(_ value: Value, forKey key: String, cost: Int) {
        storage.setObject(value, forKey: key as NSString, cost: cost)
    }
    
    func value(forKey key: String) -> Value? {
        let cachedValue = storage.object(forKey: key as NSString)
        return cachedValue
    }
    
    func remove(forKey key: String) {
        storage.removeObject(forKey: key as NSString)
    }
    
    func removeAll() {
        storage.removeAllObjects()
    }
}
