//
//  MockSettingsView.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

final class MockSettingsView: SettingsViewProtocol {
    var presenter: SettingsPresenterProtocol?
    
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showAlertCalled = false
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showAlert(title: String, message: String) {
        showAlertCalled = true
    }
}
