import UIKit

extension UIColor {
    static let buttonBlue = UIColor(red: 29.0 / 255.0, green: 106.0 / 255.0, blue: 1.0, alpha: 1.0)
    static func buttonGradient(alpha: CGFloat) -> Self {
        return Self.init(red: 29.0 / 255.0, green: 180.0 / 255.0, blue: 1.0, alpha: alpha)
    }

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
