import UIKit
import GiphyDomainInterface
import SearchFeatureInterface

struct SearchFactoryImpl: SearchFactory {
    
    private let searchUseCase: SearchUseCase
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = SearchViewModel(searchUseCase: searchUseCase)
        let viewController = SearchViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
