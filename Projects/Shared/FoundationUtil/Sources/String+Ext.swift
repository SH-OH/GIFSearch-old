import Foundation

public extension String {
    var int: Int? {
        Int(self)
    }
    
    var cgFloat: CGFloat? {
        CGFloat(Double(self) ?? 0.0)
    }
    
    var url: URL? {
        URL(string: self)
    }
}
