import Foundation
import RxSwift
import RxCocoa
import BaseFeature
import DesignSystem
import FoundationUtil
import GlobalThirdPartyLibrary

// MARK: - Inputs

protocol MainTabBarViewModelInputs {
    
}

// MARK: - Outputs

protocol MainTabBarViewModelOutputs {
    var children: [MainTabBarChildItem] { get }
}

// MARK: - ViewModelType

protocol MainTabBarViewModelType: ViewModelType {
    var inputs: MainTabBarViewModelInputs { get }
    var outputs: MainTabBarViewModelOutputs { get }
}

// MARK: - ViewModel Implements

final class MainTabBarViewModel: MainTabBarViewModelType,
                           MainTabBarViewModelInputs,
                           MainTabBarViewModelOutputs {
    
    var inputs: MainTabBarViewModelInputs { self }
    var outputs: MainTabBarViewModelOutputs { self }
    
    let children: [MainTabBarChildItem]
    
    private let disposeBag: DisposeBag = .init()
    
    deinit { print(#function, "[\(String(describing: Self.self))]") }
    
    init(children: [MainTabBarChildItem]) {
        self.children = children
    }
}
