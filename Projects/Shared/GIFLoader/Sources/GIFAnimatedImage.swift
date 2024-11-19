import UIKit

public struct GIFAnimatedImage: Sendable {
    public let images: [UIImage]
    public let duration: TimeInterval
    
    init?(data: Data, fixedWidth: CGFloat = 200.0) {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        
        for index in 0..<count {
            autoreleasepool {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, index, nil) {
                    let image = UIImage(cgImage: cgImage)
                    let scale = fixedWidth / image.size.width
                    let size: CGSize = .init(width: fixedWidth, height: scale * image.size.height)
                    
                    images.append(image.resized(targetSize: size) ?? image)
                    let frameDuration = GIFAnimatedImage.frameDuration(at: index, source: source)
                    totalDuration += frameDuration
                }
            }
        }
        
        self.images = images
        self.duration = totalDuration
    }
}

private extension GIFAnimatedImage {
    static func frameDuration(at index: Int, source: CGImageSource) -> TimeInterval {
        guard
            let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as NSDictionary?,
            let gifProperties = frameProperties[kCGImagePropertyGIFDictionary] as? NSDictionary
        else {
            return 0.0
        }
        
        let defaultFrameDuration = 0.1
        
        let unclampedDelayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime] as? TimeInterval
        let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval
        
        guard let duration = unclampedDelayTime ?? delayTime else { return defaultFrameDuration }
        
        return duration > 0.011 ? duration : defaultFrameDuration
    }
}

private extension UIImage {
    func resized(targetSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        draw(in: .init(origin: .zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
