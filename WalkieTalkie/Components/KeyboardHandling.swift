//
//  KeyboardHandling.swift
//  WalkieTalkie
//

//

import UIKit

protocol KeyboardScrollable where Self: UIViewController {
    var keyboardScrollableView: UIScrollView { get }
    func startObservingKeyboard()
    func stopObservingKeyboard()
}

protocol KeyboardDismissable where Self: UIViewController {
    func startHidingKeyboardOnTap()
}

protocol KeyboardConstraintAdjustable100 where Self: UIViewController {
    var bottomConstraintToAdjust: NSLayoutConstraint { get }
    func startObservingKeyboardWithConstraintAdjustment()
    func stopObservingKeyboardWithConstraintAdjustment()
}

protocol KeyboardConstraintAdjustable0 where Self: UIViewController {
    var bottomConstraintToAdjust: NSLayoutConstraint { get }
    func startObservingKeyboardWithConstraintAdjustment()
    func stopObservingKeyboardWithConstraintAdjustment()
}

extension KeyboardScrollable {
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        addTapGestureToDismissKeyboard()
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        (self as UIViewController).view.addGestureRecognizer(tapGesture)
    }
}

extension KeyboardDismissable {
    func startHidingKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

extension KeyboardConstraintAdjustable100 {
    func startObservingKeyboardWithConstraintAdjustment() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWithConstraintWillShow100(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWithConstraintWillHide100(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func stopObservingKeyboardWithConstraintAdjustment() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension KeyboardConstraintAdjustable0 {
    func startObservingKeyboardWithConstraintAdjustment() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWithConstraintWillShow0(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWithConstraintWillHide0(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func stopObservingKeyboardWithConstraintAdjustment() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension UIViewController {
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        guard let selfWithScroll = self as? KeyboardScrollable else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        selfWithScroll.keyboardScrollableView.contentInset = contentInset
        selfWithScroll.keyboardScrollableView.scrollIndicatorInsets = contentInset
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        guard let selfWithScroll = self as? KeyboardScrollable else { return }
        let contentInset = UIEdgeInsets.zero
        selfWithScroll.keyboardScrollableView.contentInset = contentInset
        selfWithScroll.keyboardScrollableView.scrollIndicatorInsets = contentInset
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleKeyboardWithConstraintWillShow100(_ notification: Notification) {
        guard let selfWithConstraint = self as? KeyboardConstraintAdjustable100,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        selfWithConstraint.bottomConstraintToAdjust.constant = keyboardFrame.height
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardWithConstraintWillHide100(_ notification: Notification) {
        guard let selfWithConstraint = self as? KeyboardConstraintAdjustable100,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        selfWithConstraint.bottomConstraintToAdjust.constant = 100
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardWithConstraintWillShow0(_ notification: Notification) {
        guard let selfWithConstraint = self as? KeyboardConstraintAdjustable0,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        selfWithConstraint.bottomConstraintToAdjust.constant = keyboardFrame.height
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardWithConstraintWillHide0(_ notification: Notification) {
        guard let selfWithConstraint = self as? KeyboardConstraintAdjustable0,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        selfWithConstraint.bottomConstraintToAdjust.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
