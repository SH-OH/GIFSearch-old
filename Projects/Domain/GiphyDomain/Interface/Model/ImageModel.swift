import Foundation

public struct ImageModel: Hashable {
    public let uuid: UUID
    public let height: CGFloat
    public let width: CGFloat
    public let size: Int
    public let url: URL?
    
    public init(
        uuid: UUID = .init(),
        height: CGFloat,
        width: CGFloat,
        size: Int,
        url: URL?
    ) {
        self.uuid = uuid
        self.height = height
        self.width = width
        self.size = size
        self.url = url
    }
}
