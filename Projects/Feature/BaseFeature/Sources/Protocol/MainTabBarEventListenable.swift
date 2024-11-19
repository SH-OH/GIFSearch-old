import UIKit

public protocol MainTabBarEventListenable: UIViewController {
    func mainTabDidTap(_ tabNumber: Int)
}
