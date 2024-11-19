import UIKit
import SnapKit
import BaseFeature
import DesignSystem
import GlobalThirdPartyLibrary
import GiphyDomainInterface

final class MainTabBarController: UITabBarController,
                                   ViewModelBindable {
    
    // MARK: - Typealiases
    
    typealias ViewModelType = MainTabBarViewModelType
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    let viewModel: (any ViewModelType)?
    
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
        configureViews()
        bind(viewModel)
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemGray3,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        tabBarItemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.shadowColor = .clear
        
        tabBar.standardAppearance = tabBarAppearance
        
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func bind(_ viewModel: (any ViewModelType)?) {
        guard let viewModel else {
            preconditionFailure("\(ViewModel.self) must be set.")
        }
        
        let viewControllers = viewModel.outputs.children
            .map({
                let tabBarItem = UITabBarItem(title: $0.tabBar.title, image: nil, tag: $0.tabBar.rawValue)
                $0.child.tabBarItem = tabBarItem
                
                return $0.child
            })
        
        setViewControllers(viewControllers, animated: true)
    }
}
