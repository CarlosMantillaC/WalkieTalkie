//
//  KeyboardHandling.swift
//  WalkieTalkie
//

//

import UIKit

protocol KeyboardScrollable where Self: UIViewController {
    var keyboardScrollableView: UIScrollView? { get }
    func startObservingKeyboard()
    func stopObservingKeyboard()
}

protocol KeyboardDismissable where Self: UIViewController {
    func startHidingKeyboardOnTap()
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

extension UIViewController {
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        guard let selfWithScroll = self as? KeyboardScrollable else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        selfWithScroll.keyboardScrollableView?.contentInset = contentInset
        selfWithScroll.keyboardScrollableView?.scrollIndicatorInsets = contentInset
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        guard let selfWithScroll = self as? KeyboardScrollable else { return }
        let contentInset = UIEdgeInsets.zero
        selfWithScroll.keyboardScrollableView?.contentInset = contentInset
        selfWithScroll.keyboardScrollableView?.scrollIndicatorInsets = contentInset
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
