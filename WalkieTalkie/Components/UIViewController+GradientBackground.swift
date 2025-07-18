//
//  UIViewController+GradientBackground.swift
//  WalkieTalkie
//

//

import UIKit

private var gradientKey: UInt8 = 0

extension UIViewController {

    private var gradientLayer: CAGradientLayer? {
        get { objc_getAssociatedObject(self, &gradientKey) as? CAGradientLayer }
        set { objc_setAssociatedObject(self, &gradientKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func applyGradientBackground(
        topColor: UIColor = UIColor.fromHex("#4b0082"),
        bottomColor: UIColor = UIColor.fromHex("#4a00e0")
    ) {
        if gradientLayer == nil {
            let layer = CAGradientLayer()
            layer.colors = [topColor.cgColor, bottomColor.cgColor]
            layer.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer.endPoint = CGPoint(x: 0.5, y: 1.0)
            layer.frame = view.bounds
            view.layer.insertSublayer(layer, at: 0)
            gradientLayer = layer
        } else {
            gradientLayer?.frame = view.bounds
        }
    }
}
