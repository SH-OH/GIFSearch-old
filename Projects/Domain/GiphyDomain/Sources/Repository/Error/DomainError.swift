import Foundation

protocol DomainError: Error, CaseIterable {}

extension DomainError where Self: RawRepresentable<Int> {
    static func toErrorMap() -> [Int: Error] {
        return allCases.reduce(into: [Int: Error](), { $0[$1.rawValue] = $1 })
    }
}
