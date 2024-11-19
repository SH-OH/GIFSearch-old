import ProjectDescription

public typealias DEP = TargetDependency

public extension DEP {
    struct SPM {}
}

public extension DEP.SPM {
    static let SnapKit: DEP = .external(name: "SnapKit", condition: nil)
    static let Swinject: DEP = .external(name: "Swinject", condition: nil)
    static let RxSwift: DEP = .external(name: "RxSwift", condition: nil)
    static let RxCocoa: DEP = .external(name: "RxCocoa", condition: nil)
    static let RxRelay: DEP = .external(name: "RxRelay", condition: nil)
}
