import UIKit

class ViewController: UIViewController {
    // MARK: - properties
    private lazy var animationButton: AnimatedButton = {
        let button = AnimatedButton()
        button.setTitle("Sign in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - private methods
    private func setup() {
        view.backgroundColor = .green
        view.addSubview(animationButton)
        setupConstraints()
    }

    private func setupConstraints() {
        animationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultOffset).isActive = true
        animationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultOffset).isActive = true
        animationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.defaultOffset).isActive = true
        animationButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
    }
}

// MARK: - Constants
private extension ViewController {
    enum Constants {
        static let defaultOffset = 16.0
        static let buttonHeight = 56.0
    }
}

