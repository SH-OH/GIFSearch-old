import Foundation

public struct GiphyModel: Hashable {
    public let totalCount: Int
    public let models: [ImageModel]
    
    public init(totalCount: Int, models: [ImageModel]) {
        self.totalCount = totalCount
        self.models = models
    }
}

extension GiphyModel {
    public struct Item {
        public let id: String
        public let images: [ImageType: ImageModel]
        
        public init(id: String, images: [ImageType: ImageModel]) {
            self.id = id
            self.images = images
        }
    }
}

extension GiphyModel.Item: Hashable {
    public static func == (lhs: GiphyModel.Item, rhs: GiphyModel.Item) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        images.forEach { (key, value) in
            hasher.combine(key)
            hasher.combine(value)
        }
    }
}
