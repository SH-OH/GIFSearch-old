import UIKit
import GiphyDomainInterface
import HomeFeatureInterface

struct HomeFactoryImpl: HomeFactory {
    
    private let trendingUseCase: TrendingUseCase
    
    init(trendingUseCase: TrendingUseCase) {
        self.trendingUseCase = trendingUseCase
    }
    
    func makeViewController() -> UIViewController {
        let viewModel = HomeViewModel(trendingUseCase: trendingUseCase)
        let viewController = HomeViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
