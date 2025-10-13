//
//  MockSettingsPresenter.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

final class MockSettingsPresenter: SettingsInteractorOutputProtocol {
    var didLogoutSuccessfullyCalled = false
    
    func didLogoutSuccessfully() {
        didLogoutSuccessfullyCalled = true
    }
}
