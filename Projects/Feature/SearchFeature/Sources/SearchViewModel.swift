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

extension ImageModel: ImageRepresentable {}
extension ImageModel: GIFViewDisplayable {}

// MARK: - Inputs

protocol SearchViewModelInputs {
    func searchText(_ keyword: String)
    func willDisplayCell(_ indexPath: IndexPath)
}

// MARK: - Outputs

protocol SearchViewModelOutputs {
    var imageModelsValue: [ImageModel] { get }
    var imageModels: Driver<[ImageModel]> { get }
    var errorMessage: Driver<String> { get }
}

// MARK: - ViewModelType

protocol SearchViewModelType: ViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

// MARK: - ViewModel Implements

final class SearchViewModel: SearchViewModelType,
                           SearchViewModelInputs,
                           SearchViewModelOutputs {
    
    var inputs: SearchViewModelInputs { self }
    var outputs: SearchViewModelOutputs { self }
    
    var imageModelsValue: [ImageModel] { imageModelsRelay.value }
    var imageModels: Driver<[ImageModel]> { imageModelsRelay.asDriverWithEmpty() }
    var errorMessage: Driver<String> { errorMessageRelay.asDriverWithEmpty() }
    
    private let imageModelsRelay: BehaviorRelay<[ImageModel]> = .init(value: [])
    private let errorMessageRelay: PublishRelay<String> = .init()
    private let disposeBag: DisposeBag = .init()
    
    private let searchUseCase: SearchUseCase
    
    private lazy var paginationState: PaginationState = .init()
    
    private var searchKeyword: String = ""
    
    deinit { print(#function, "[\(String(describing: Self.self))]") }
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func searchText(_ keyword: String) {
        searchKeyword = keyword
        
        guard checkSearchKeyword(searchKeyword) else { return }
        
        
        fetchTrendingGIFs(query: searchKeyword, fetchType: .new)
    }
    
    func willDisplayCell(_ indexPath: IndexPath) {
        guard checkSearchKeyword(searchKeyword) else { return }
        guard paginationState.shouldLoadNextOffset(itemCount: imageModelsValue.count, at: indexPath) else {
            return
        }
        
        fetchTrendingGIFs(query: searchKeyword, fetchType: .loadMore)
    }
}

// MARK: - Private Methods

private extension SearchViewModel {
    func checkSearchKeyword(_ keyword: String) -> Bool {
        guard !keyword.isEmpty else {
            paginationState = paginationState.reset()
            imageModelsRelay.accept([])
            return false
        }
        
        return true
    }
    
    func fetchTrendingGIFs(query: String, fetchType: FetchType) {
        let prevPaginationState = paginationState
        let startPaginationState = fetchType == .loadMore
        ? prevPaginationState.prepareNextOffset(itemCount: imageModelsValue.count)
        : prevPaginationState.reset()
        
        paginationState = startPaginationState
        
        searchUseCase(query: query, offset: startPaginationState.currentOffset)
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
