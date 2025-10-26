//
//  MockListUsersPresenter.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockListUsersPresenter: ListUsersInteractorOutputProtocol {
    var didFetchUsersCalled = false
    var didFailToFetchUsersCalled = false
    var users: [String]?
    var error: Error?

    func didFetchUsers(_ users: [String]) {
        didFetchUsersCalled = true
        self.users = users
    }

    func didFailToFetchUsers(with error: Error) {
        didFailToFetchUsersCalled = true
        self.error = error
    }
}
