import Foundation
import RxSwift
import RxCocoa
import BaseFeature
import DesignSystem
import FoundationUtil
import GlobalThirdPartyLibrary
import GiphyDomainInterface
import GIFLoader

// MARK: ImageModel Conforming

extension ImageModel: @retroactive ImageRepresentable {}
extension ImageModel: @retroactive GIFViewDisplayable {}

// MARK: - Inputs

protocol HomeViewModelInputs {
    func viewDidLoad()
    func willDisplayCell(_ indexPath: IndexPath)
}

// MARK: - Outputs

protocol HomeViewModelOutputs {
    var imageModelsValue: [ImageModel] { get }
    var imageModels: Driver<[ImageModel]> { get }
    var errorMessage: Driver<String> { get }
}

// MARK: - ViewModelType

protocol HomeViewModelType: ViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

// MARK: - ViewModel Implements

final class HomeViewModel: HomeViewModelType,
                           HomeViewModelInputs,
                           HomeViewModelOutputs {
    
    var inputs: HomeViewModelInputs { self }
    var outputs: HomeViewModelOutputs { self }
    
    var imageModelsValue: [ImageModel] { imageModelsRelay.value }
    var imageModels: Driver<[ImageModel]> { imageModelsRelay.asDriverWithEmpty() }
    var errorMessage: Driver<String> { errorMessageRelay.asDriverWithEmpty() }
    
    private let imageModelsRelay: BehaviorRelay<[ImageModel]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let disposeBag: DisposeBag = .init()
    
    private let trendingUseCase: TrendingUseCase
    
    private lazy var paginationState: PaginationState = .init()
    
    deinit { print(#function, "[\(String(describing: Self.self))]") }
    
    init(trendingUseCase: TrendingUseCase) {
        self.trendingUseCase = trendingUseCase
    }
    
    func viewDidLoad() {
        fetchTrendingGIFs(fetchType: .new)
    }
    
    func willDisplayCell(_ indexPath: IndexPath) {
        guard paginationState.shouldLoadNextOffset(itemCount: imageModelsValue.count, at: indexPath) else {
            return
        }
        
        fetchTrendingGIFs(fetchType: .loadMore)
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func fetchTrendingGIFs(fetchType: FetchType) {
        let prevPaginationState = paginationState
        let startPaginationState = fetchType == .loadMore
        ? prevPaginationState.prepareNextOffset(itemCount: imageModelsValue.count)
        : prevPaginationState.prepareReset()
        
        paginationState = startPaginationState
        
        trendingUseCase(offset: startPaginationState.currentOffset)
            .subscribe(with: self, onSuccess: { owner, result in
                let imageModel = result.models
                
                switch fetchType {
                case .new:
                    owner.imageModelsRelay.accept(imageModel)
                    
                case .loadMore:
                    owner.imageModelsRelay.append(imageModel)
                }
                owner.paginationState = startPaginationState.finish(totalCount: result.totalCount)
                
            }, onFailure: { owner, error in
                owner.paginationState = prevPaginationState
                owner.errorMessageRelay.accept(error.localizedDescription)  
            })
            .disposed(by: disposeBag)
    }
}
