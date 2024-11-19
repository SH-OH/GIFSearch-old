import UIKit
import RxSwift
import RxCocoa
import SnapKit
import BaseFeature
import DesignSystem
import GlobalThirdPartyLibrary
import GiphyDomainInterface

final class HomeViewController: BaseViewController,
                                Alertable,
                                ViewModelBindable {
    
    // MARK: - Typealiases
    
    typealias ViewModelType = HomeViewModelType
    typealias Item = ImageModel
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    enum Section: Hashable {
        case main
    }
    
    // MARK: - UI Components
    
    private lazy var layoutComponent: PinterestLayoutComponent = .init(
        numberOfColumns: 2,
        spacing: 10,
        sectionInsets: .init(top: 10, left: 10, bottom: 10, right: 10)
    ) {
        self.viewModel?.outputs.imageModelsValue ?? []
    }
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layoutComponent.createLayout())
        collectionView.allowsSelection = false
        collectionView.register(cellType: HomeCell.self)
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    let viewModel: (any ViewModelType)?
    
    private lazy var dataSource: DataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
        let cell = collectionView.dequeue(HomeCell.self, for: indexPath)
        
        cell.configure(with: item as GIFViewDisplayable)
        
        return cell
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: (any ViewModelType)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(_ viewModel: (any ViewModelType)?) {
        guard let viewModel else {
            preconditionFailure("\(ViewModel.self) must be set.")
        }
        
        bindOutput(viewModel)
        bindInput(viewModel)
    }
    
    private func bindInput(_ viewModel: ViewModel) {
        viewModel.inputs.viewDidLoad()
        
        collectionView.rx.willDisplayCell
            .do(onNext: { cell, _ in
                (cell as? GIFImageEventHandlable)?.play()
            })
            .map(\.at)
            .bind(onNext: viewModel.inputs.willDisplayCell(_:))
            .disposed(by: disposeBag)
        
        collectionView.rx.didEndDisplayingCell
            .compactMap({ $0.cell as? GIFImageEventHandlable })
            .bind(onNext: { cell in
                cell.stop()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindOutput(_ viewModel: ViewModel) {
        viewModel.outputs.imageModels
            .distinctUntilChanged()
            .drive(with: self, onNext: { owner, models in
                owner.update(with: models)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.errorMessage
            .drive(with: self, onNext: { owner, errorMessage in
                owner.showAlert(message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func update(with items: [Item]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: MainTabBarEventListenable {
    func mainTabDidTap(_ tabNumber: Int) {
        collectionView.setContentOffset(.zero, animated: true)
    }
}
