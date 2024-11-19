import Foundation

public enum HTTPMethod: String, RawRepresentable {
    case get
    
    public var rawValue: String {
        "\(self)".uppercased()
    }
}
