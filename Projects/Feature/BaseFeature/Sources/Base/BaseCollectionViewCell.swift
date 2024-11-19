import UIKit

open class BaseCollectionViewCell<Item>: UICollectionViewCell,
                              CellConfigurable {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    open func configure(with item: Item) { }
    
    open func configureViews() {}
    
    open func configureLayout() {}
}
