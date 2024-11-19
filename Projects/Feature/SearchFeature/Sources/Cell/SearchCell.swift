import UIKit
import BaseFeature
import DesignSystem

final class SearchCell: BaseCollectionViewCell<GIFViewDisplayable>,
                        GIFImageEventHandlable {
    
    private lazy var itemView: GIFView = .init(frame: .zero)
    
    override func configureViews() {
        contentView.addSubview(itemView)
    }
    
    override func configureLayout() {
        itemView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configure(with item: any GIFViewDisplayable) {
        super.configure(with: item)
        
        itemView.configure(item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemView.prepareForReuse()
    }
    
    public func play() {
        itemView.play()
    }
    
    public func stop() {
        itemView.stop()
    }
}
