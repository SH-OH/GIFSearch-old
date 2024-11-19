import UIKit
import SnapKit
import GIFLoader
import UIKitUtil

public protocol GIFViewDisplayable {
    var url: URL? { get }
}

public protocol GIFImageEventHandlable {
    func play()
    func stop()
}

open class GIFView: UIView {
    
    public typealias IndexPathValidation = (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> Void
    
    private lazy var layerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    private lazy var placeholderImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    private var task: URLSessionDataTask?
    private var identifier: UUID?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureViews() {
        addSubview(layerView)
        layerView.addSubview(imageView)
        layerView.addSubview(placeholderImageView)
    }
    
    open func configureLayout() {
        layerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        placeholderImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    open func prepareForReuse() {
        stop()
        cancelDownload()
        clearImageView()
        
        placeholderImageView.isHidden = false
        
        identifier = nil
    }
    
    public func configure(_ model: some GIFViewDisplayable) {
        let identifier = UUID()
        self.identifier = identifier
        
        task = GIFLoader.shared.retrieveGIF(model.url) { [weak self] result in
            guard let self else { return }
            
            guard self.identifier == identifier else {
                return
            }
            
            let gifImage = try? result.get()
            self.placeholderImageView.isHidden = gifImage != nil
            
            self.imageView.animationImages = gifImage?.images
            self.imageView.animationDuration = gifImage?.duration ?? 0.0
            
            UIView.animate(withDuration: 0.5) {
                self.imageView.startAnimating()
                self.imageView.alpha = 1
                self.layoutIfNeeded()
            }
        }
    }
    
    public func play() {
        guard !imageView.isAnimating else { return }
        
        imageView.startAnimating()
    }
    
    public func stop() {
        guard imageView.isAnimating else { return }
        
        imageView.stopAnimating()
    }
    
    private func cancelDownload() {
        task?.cancel()
        task = nil
    }
    
    private func clearImageView() {
        imageView.image = nil
        imageView.animationImages = nil
        imageView.alpha = 0
    }
}
