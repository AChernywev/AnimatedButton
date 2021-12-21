import UIKit

protocol AnimatorProtocol {
    func startAnimation(in view: UIView, from location: CGPoint)
}

class CircleRippleAnimator: AnimatorProtocol {
    // MARK: - properties
    private let circleSize: CGFloat
    private let circleColor: UIColor
    private let highlightScale: CGFloat

    // MARK: - initialization
    init(circleSize: CGFloat = Constants.circleSize, circleColor: UIColor = Constants.circleColor, highlightScale: CGFloat = Constants.highlightScale) {
        self.circleSize = circleSize
        self.circleColor = circleColor
        self.highlightScale = highlightScale
    }

    // MARK: - AnimatorProtocol
    func startAnimation(in view: UIView, from location: CGPoint) {
        animateScaleHighlight(for: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
            self.animateCircleRipple(in: view, from: location)
        }
    }

    // MARK: - private methods
    private func animateScaleHighlight(for view: UIView) {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseIn],
            animations: {
                view.transform = CGAffineTransform(scaleX: self.highlightScale, y: self.highlightScale)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.25,
                    delay: 0,
                    options: [.beginFromCurrentState, .curveEaseOut],
                    animations: {
                        view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    },
                    completion: nil
                )
            }
        )
    }

    private func animateCircleRipple(in view: UIView, from location: CGPoint) {
        //creating circle view
        let circle = UIView()
        circle.backgroundColor = circleColor
        circle.clipsToBounds = true
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = circleSize / 2.0
        view.addSubview(circle)

        //setting up constraints
        let sizeConstraint = circle.heightAnchor.constraint(equalToConstant: circleSize)
        sizeConstraint.isActive = true
        circle.heightAnchor.constraint(equalTo: circle.widthAnchor).isActive = true
        circle.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: location.x).isActive = true
        circle.centerYAnchor.constraint(equalTo: view.topAnchor, constant: location.y).isActive = true
        view.layoutIfNeeded()

        //ripple animation
        let finalSize = max(view.bounds.size.width, view.bounds.size.height) * 2
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                circle.layer.cornerRadius = finalSize / 2.0
                sizeConstraint.constant = finalSize
                view.layoutIfNeeded()
            },
            completion: nil
        )
        UIView.animate(
            withDuration: 0.5,
            delay: 0.15,
            options: [.beginFromCurrentState],
            animations: {
                circle.alpha = 0
            },
            completion: { _ in
                circle.removeFromSuperview()
            }
        )
    }
}

// MARK: - Constants
private extension CircleRippleAnimator {
    enum Constants {
        static let circleSize = 15.0
        static let circleColor = UIColor.white.withAlphaComponent(0.95)
        static let highlightScale = 0.97
    }
}
