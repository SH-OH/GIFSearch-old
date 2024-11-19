import UIKit
import BaseFeature
import HomeFeatureInterface
import SearchFeatureInterface
import MainTabFeatureInterface

struct MainTabBarFactoryImpl: MainTabBarFactory {
    
    private let homeFactory: HomeFactory
    private let searchFactory: SearchFactory
    
    init(homeFactory: HomeFactory, searchFactory: SearchFactory) {
        self.homeFactory = homeFactory
        self.searchFactory = searchFactory
    }
    
    func makeViewController() -> UIViewController {
        let children = [
            homeFactory.makeViewController(),
            searchFactory.makeViewController()
        ].enumerated()
            .compactMap({ (offset, element) -> MainTabBarChildItem? in
                guard
                    let child = element as? MainTabBarEventListenable,
                    let tabBar = TabBar(rawValue: offset)
                else {
                    return nil
                }
                
                return MainTabBarChildItem(child: child, tabBar: tabBar)
            })
        
        let viewModel = MainTabBarViewModel(children: children)
        let viewController = MainTabBarController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
