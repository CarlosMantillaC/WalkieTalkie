//
//  MockListUsersInteractor.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockListUsersInteractor: ListUsersInteractorInputProtocol {
    var presenter: ListUsersInteractorOutputProtocol?
    var fetchUsersCalled = false

    func fetchUsers() {
        fetchUsersCalled = true
    }
}
