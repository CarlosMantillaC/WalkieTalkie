//
//  StyleTextField.swift
//  WalkieTalkie
//

//

import UIKit

class StyledTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    private func setupStyle() {
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 20
        backgroundColor = .black
        clipsToBounds = true
        textColor = .white
        
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        }
    }
}
