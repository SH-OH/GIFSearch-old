public protocol CellConfigurable {
    associatedtype Item
    func configure(with item: Item)
}
