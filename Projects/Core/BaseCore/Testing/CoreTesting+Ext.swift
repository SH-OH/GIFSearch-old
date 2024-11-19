import Foundation
import UIKit

extension URL {
    func toImage() throws -> UIImage! {
        return UIImage(data: try toData())
    }
    
    func toData() throws -> Data {
        try Data(contentsOf: self)
    }
}

extension Data {
    func toImage() throws -> UIImage! {
        return UIImage(data: self)
    }
}
