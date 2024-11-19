import Foundation

public protocol ViewModelBindable {
    associatedtype ViewModel = ViewModelType
    var viewModel: ViewModel? { get }
    func bind(_ viewModel: ViewModel?)
}

public protocol ViewModelType {
    associatedtype InputStream
    associatedtype OutputStream
    
    var inputs: InputStream { get }
    var outputs: OutputStream { get }
}
