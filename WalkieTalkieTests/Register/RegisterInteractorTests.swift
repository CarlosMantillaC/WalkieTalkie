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
            first_name: "Ana",
            last_name: "Díaz",
            email: "ana@example.com",
            password: "123456",
            confirm_password: "123456"
        )
        interactor.register(user: request)
        
        XCTAssertEqual(mockRepository.capturedRequest?.email, "ana@example.com")
    }
    
    func testRepositorySuccessShouldCallPresenterSuccess() {
        let expectation = self.expectation(description: "Success callback")
        let request = RegisterRequest(
            first_name: "A",
            last_name: "B",
            email: "a@b.com",
            password: "123",
            confirm_password: "123"
        )
        interactor.register(user: request)
        
        mockPresenter.onSuccess = {
            expectation.fulfill()
        }

        mockRepository.simulateSuccess(message: "Cuenta creada")
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(mockPresenter.successMessage, "Cuenta creada")
    }
    
    func testRepositoryFailureShouldCallPresenterFailure() {
        let expectation = self.expectation(description: "Failure callback")
        let request = RegisterRequest(
            first_name: "A",
            last_name: "B",
            email: "a@b.com",
            password: "123",
            confirm_password: "123"
        )
        interactor.register(user: request)
        
        mockPresenter.onFailure = {
            expectation.fulfill()
        }
        
        let expectedError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Falló el registro"])
        mockRepository.simulateFailure(error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(mockPresenter.receivedError?.localizedDescription, "Falló el registro")
    }
}
