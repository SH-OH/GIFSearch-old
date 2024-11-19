import UIKit

public protocol Alertable where Self: UIViewController {
    func showAlert(
        message: String,
        confirmTitle: String
    )
}

public extension Alertable {
    func showAlert(
        message: String,
        confirmTitle: String = "확인"
    ) {
        let controller = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        
        controller.addAction(confirmAction)
        
        self.present(controller, animated: true)
    }
}
