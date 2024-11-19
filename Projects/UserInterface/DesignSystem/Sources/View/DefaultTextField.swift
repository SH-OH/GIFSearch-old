import UIKit

open class DefaultTextField: UITextField {
    
    open override var placeholder: String? {
        didSet { setNeedsLayout() }
    }
    
    public var textAreaInsets: UIEdgeInsets = .init(
        top: 0,
        left: 12,
        bottom: 0,
        right: 12
    )
    
    private lazy var searchImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    private lazy var leftInset: CGFloat = textAreaInsets.left + (searchImageView.image?.size.width ?? 20) + 6
    private lazy var rightInset: CGFloat = textAreaInsets.right + 20 + 6
    
    public init(placeholder: String? = "") {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setPlaceholderTextColor()
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let right = clearButtonMode == .always ? rightInset : 0
        return bounds.inset(
            by: .init(
                top: textAreaInsets.top,
                left: leftInset,
                bottom: textAreaInsets.bottom,
                right: right
            )
        )
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(
            by: .init(
                top: textAreaInsets.top,
                left: leftInset,
                bottom: textAreaInsets.bottom,
                right: rightInset
            )
        )
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.offsetBy(dx: textAreaInsets.left, dy: 0)
    }
    
    open override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -textAreaInsets.right, dy: 0)
    }
}

private extension DefaultTextField {
    func configure() {
        backgroundColor = .systemGray6
        textColor = .black
        font = .systemFont(ofSize: 14, weight: .bold)
        clearButtonMode = .whileEditing
        returnKeyType = .search
        autocorrectionType = .no
        
        borderStyle = .none
        layer.cornerRadius = 8
        clipsToBounds = true
        
        leftView = searchImageView
        leftViewMode = .always
    }
    
    func setPlaceholderTextColor() {
        guard let placeholder else { return }
        
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.systemGray3
            ]
        )
    }
}

