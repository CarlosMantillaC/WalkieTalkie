//
//  MockSettingsInteractor.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

final class MockSettingsInteractor: SettingsInteractorInputProtocol {
    var presenter: SettingsInteractorOutputProtocol?
    var performLogoutCalled = false
    
    func performLogout() {
        performLogoutCalled = true
    }
}
