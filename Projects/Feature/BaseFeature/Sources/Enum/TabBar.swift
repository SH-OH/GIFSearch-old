import Foundation

public enum TabBar: Int {
    case home
    case search
    
    public var title: String {
        switch self {
        case .home:
            return "홈"
        case .search:
            return "검색"
        }
    }
}
