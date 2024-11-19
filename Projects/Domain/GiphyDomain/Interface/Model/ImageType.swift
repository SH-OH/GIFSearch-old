import Foundation

public enum ImageType: String, RawRepresentable {
    case fixedWidth = "fixed_width"
    case downsized = "downsized"
    
    public init?(rawValue: String) {
        switch rawValue {
        case "fixed_width":
            self = .fixedWidth
            return
            
        case "downsized":
            self = .downsized
            return
         
        default:
            return nil
        }
    }
}
