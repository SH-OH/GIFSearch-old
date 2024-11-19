import UIKit

public extension UICollectionView {
    final func register(cellType: (some UICollectionViewCell).Type) {
        register(
            cellType.self,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
    final func register(viewType: (some UICollectionReusableView).Type, kind: String) {
        register(
            viewType.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: viewType.reuseIdentifier
        )
    }
    
    final func dequeue<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Failed dequeue reuse Cell : \(cellType)")
        }
        return cell
    }
    
    final func dequeue<View: UICollectionReusableView>(_ viewType: View.Type, kind: String, for indexPath: IndexPath) -> View {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        ) as? View else {
            fatalError("Failed dequeue reuse Cell : \(viewType)")
        }
        return view
    }
}
