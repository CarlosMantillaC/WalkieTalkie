//
//  LoginInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginInteractorTests: XCTestCase {
    var interactor: LoginInteractor!
    var mockRepository: MockLoginRepository!
    var mockPresenter: MockLoginInteractorOutput!

    override func setUp() {
        super.setUp()
        
        mockRepository = MockLoginRepository()
        mockPresenter = MockLoginInteractorOutput()
        interactor = LoginInteractor(repository: mockRepository)
        
        interactor.presenter = mockPresenter
    }

    func testLoginSuccessNotifiesPresenter() {
        let expectation = self.expectation(description: "login success")

        let expectedResponse = LoginResponse(accessToken: "abc123", accessTokenExpiresIn: 3600, email: "", first_name: "", last_name: "", refreshToken: "", refreshTokenExpiresAt: "", user_id: 1)
        mockRepository.resultToReturn = .success(expectedResponse)
        mockPresenter.onSuccess = {
            expectation.fulfill()
        }

        let request = LoginRequest(email: "user@test.com", password: "123456")
        interactor.login(request: request)

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(mockRepository.capturedRequest?.email, "user@test.com")
        XCTAssertEqual(mockPresenter.lastSuccessResponse?.accessToken, "abc123")
    }

    func testLoginFailureNotifiesPresenter() {
        let expectation = self.expectation(description: "login failure")

        let expectedError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error de login"])
        mockRepository.resultToReturn = .failure(expectedError)
        mockPresenter.onFailure = {
            expectation.fulfill()
        }

        let request = LoginRequest(email: "user@test.com", password: "123456")
        interactor.login(request: request)

        waitForExpectations(timeout: 1.0)

        XCTAssertEqual(mockPresenter.receivedError?.localizedDescription, "Error de login")
    }
}
