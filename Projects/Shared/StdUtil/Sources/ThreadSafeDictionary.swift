import Foundation

public actor ThreadSafeDictionary<Key: Hashable, Value> {
    
    private var dictionary: [Key: Value]
    
    public init(dictionary: [Key : Value] = [:]) {
        self.dictionary = dictionary
    }
    
    public subscript(_ key: Key) -> Value? {
        dictionary[key]
    }
    
    public func update(_ value: Value, forKey key: Key) {
        dictionary[key] = value
    }
    
    public func removeValue(forKey key: Key) {
        dictionary.removeValue(forKey: key)
    }
    
    public func removeAll(keepingCapacity: Bool = false) {
        dictionary.removeAll(keepingCapacity: keepingCapacity)
    }
}
