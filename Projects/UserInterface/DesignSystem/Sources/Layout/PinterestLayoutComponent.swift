import UIKit

public struct PinterestLayoutComponent {
    public typealias DataProvider = () -> [ImageRepresentable]
    
    public let numberOfColumns: Int
    public let spacing: CGFloat
    public let sectionInsets: UIEdgeInsets
    public let dataProvider: DataProvider
    
    public init(
        numberOfColumns: Int,
        spacing: CGFloat,
        sectionInsets: UIEdgeInsets,
        dataProvider: @escaping DataProvider
    ) {
        self.dataProvider = dataProvider
        self.spacing = spacing
        self.sectionInsets = sectionInsets
        self.numberOfColumns = numberOfColumns
    }
    
    public func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, sectionLayout) -> NSCollectionLayoutSection? in
            let imageModels = dataProvider()
            let collectionViewSize = sectionLayout.container.effectiveContentSize
            let itemWidth = (collectionViewSize.width - (CGFloat(numberOfColumns + 1) * spacing)) / CGFloat(numberOfColumns)
            
            var items = [NSCollectionLayoutGroupCustomItem]()
            var yOffsets: Array<CGFloat> = .init(repeating: 0, count: numberOfColumns)
            var columnHeights: Array<CGFloat> = .init(repeating: collectionViewSize.height, count: numberOfColumns)
            
            for image in imageModels {
                let scale: CGFloat = itemWidth / CGFloat(image.width)
                let itemHeight: CGFloat = scale * CGFloat(image.height)
                
                let column = yOffsets.firstIndex(of: yOffsets.min() ?? 0) ?? 0
                let xPosition = (itemWidth + spacing) * CGFloat(column)
                let frame = CGRect(
                    x: xPosition,
                    y: yOffsets[column],
                    width: itemWidth,
                    height: itemHeight
                )
                
                items.append(.init(frame: frame))
                
                yOffsets[column] += (itemHeight + spacing)
                
                columnHeights[column] = yOffsets[column]
            }
            
            let maxHeight = columnHeights.max() ?? collectionViewSize.height
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(maxHeight)
            )
            let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { _ in items }
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(
                top: sectionInsets.top,
                leading: sectionInsets.left,
                bottom: sectionInsets.bottom,
                trailing: sectionInsets.right
            )
            
            return section
        }
        return layout
    }
}
