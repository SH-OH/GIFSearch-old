import Foundation
import UIKit

public struct PaginationState {
    
    public var currentOffset: Int
    public var totalCount: Int = 0
    public var isLoading: Bool = false
    
    /// default: 0.
    let startOffset: Int
    let thresholdCount: Int
    
    public init(
        startOffset: Int = 0,
        thresholdCount: Int = 25
    ) {
        self.startOffset = startOffset
        self.currentOffset = startOffset
        self.thresholdCount = thresholdCount
    }
    
    public func shouldLoadNextOffset(itemCount: Int, at indexPath: IndexPath) -> Bool {
        guard totalCount > 0 else { return false }
        
        let threshold = threshold(itemCount: itemCount)
        
        return !isLoading 
        && indexPath.row >= threshold
        && currentOffset < totalCount
    }
    
    public func prepareReset() -> Self {
        var newState = self
        newState.isLoading = true
        newState.currentOffset = startOffset
        return newState
    }
    
    public func prepareNextOffset(itemCount: Int) -> Self {
        var newState = self
        newState.isLoading = true
        newState.currentOffset = itemCount
        return newState
    }
    
    public func finish(totalCount: Int) -> Self {
        var newState = self
        newState.isLoading = false
        newState.totalCount = totalCount
        return newState
    }
    
    public func reset() -> Self {
        let newState = prepareReset()
        return newState.finish(totalCount: 0)
    }
}

private extension PaginationState {
    func threshold(itemCount: Int) -> Int {
        max(0, itemCount - thresholdCount)
    }
}
