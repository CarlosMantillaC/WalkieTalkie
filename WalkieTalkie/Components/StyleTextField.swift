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
        layer.borderColor = UIColor.systemIndigo.cgColor
        layer.cornerRadius = 20
        clipsToBounds = true
    }
}
