import UIKit
import RxSwift

open class BaseViewController: UIViewController,
                               ViewConfigurable {
    
    public var disposeBag: DisposeBag = .init()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureLayout()
    }
    
    open func configureViews() {}
    
    open func configureLayout() {}
}
