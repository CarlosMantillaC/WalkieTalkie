//
//  RegisterInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterInteractorTests: XCTestCase {
    var interactor: RegisterInteractor!
    var mockPresenter: MockRegisterInteractorOutput!
    var mockRepository: MockRegisterRepository!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockRegisterInteractorOutput()
        mockRepository = MockRegisterRepository()
        interactor = RegisterInteractor(repository: mockRepository)
        interactor.presenter = mockPresenter
    }
    
    func testRegisterCallsRepositoryWithRequest() {
        let request = RegisterRequest(
            firstName: "Ana",
            lastName: "Díaz",
            email: "ana@example.com",
            password: "123456",
            confirmPassword: "123456"
        )
        interactor.register(user: request)
        
        XCTAssertEqual(mockRepository.capturedRequest?.email, "ana@example.com")
    }
    
    func testRepositorySuccessShouldCallPresenterSuccess() {
        let expectation = self.expectation(description: "Success callback")
        
        mockRepository.resultToReturn = .success(RegisterResponse(message: "Cuenta creada"))
        mockPresenter.onSuccess = {
            expectation.fulfill()
        }

        let request = RegisterRequest(
            firstName: "A",
            lastName: "B",
            email: "a@b.com",
            password: "123",
            confirmPassword: "123"
        )
        interactor.register(user: request)

        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(mockPresenter.successMessage, "Cuenta creada")
    }
    
    func testRepositoryFailureShouldCallPresenterFailure() {
        let expectation = self.expectation(description: "Failure callback")
        
        let expectedError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Falló el registro"])
        mockRepository.resultToReturn = .failure(expectedError)
        mockPresenter.onFailure = {
            expectation.fulfill()
        }
        
        let request = RegisterRequest(
            firstName: "A",
            lastName: "B",
            email: "a@b.com",
            password: "123",
            confirmPassword: "123"
        )
        interactor.register(user: request)

        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(mockPresenter.receivedError?.localizedDescription, "Falló el registro")
    }
}
