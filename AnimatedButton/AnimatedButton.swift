import UIKit

class AnimatedButton: UIButton {
    // MARK: - properties
    private let animator: AnimatorProtocol
    private weak var gradientLayer: CALayer?

    // MARK: - initialization
    init(animator: AnimatorProtocol = CircleRippleAnimator()) {
        self.animator = animator
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    // MARK: - private methods
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = .buttonBlue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .semibold)
        addTarget(self, action: #selector(touchDown(_:_:)), for: .touchDown)

        let layer1 = CAGradientLayer()
        layer1.colors = [
            UIColor.buttonGradient(alpha: 0.0).cgColor,
            UIColor.buttonGradient(alpha: 1.0).cgColor
        ]
        layer1.startPoint = Constants.gradientStartPoint
        layer1.endPoint = Constants.gradientEndPoint
        layer1.bounds = bounds
        layer1.opacity = Constants.opacity
        layer.addSublayer(layer1)
        gradientLayer = layer1
    }

    // MARK: - Actions
    @objc private func touchDown(_ sender: UIButton, _ event: UIEvent) {
        guard let touch = event.touches(for: self)?.first else {
            return
        }
        animator.startAnimation(in: self, from: touch.location(in: self))
    }
}

// MARK: - Constants
private extension AnimatedButton {
    enum Constants {
        static let fontSize = 14.0
        static let cornerRadius: CGFloat = 16.0
        static let opacity: Float = 0.85
        static let gradientStartPoint = CGPoint(x: 0.5, y: 0.5)
        static let gradientEndPoint = CGPoint(x: 1, y: 1)
    }
}
