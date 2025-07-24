//
//  RegisterRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterRepositoryTests: XCTestCase {
    var repository: RegisterRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        repository = RegisterRepository(session: session)
    }

    func testRegisterSuccessResponse() {
        let expectedMessage = "Registro exitoso"
        let response = RegisterResponse(message: expectedMessage)
        let responseData = try! JSONEncoder().encode(response)
        
        MockURLProtocol.mockResponseData = responseData
        MockURLProtocol.mockError = nil

        let expectation = self.expectation(description: "register completes")

        let request = RegisterRequest(first_name: "Ana", last_name: "Gómez", email: "ana@mail.com", password: "123456", confirm_password: "123456")

        repository.register(user: request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.message, expectedMessage)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testRegisterReturnsAPIError() {
        let errorResponse = RegisterAPIErrorResponse(error:  "Correo ya registrado")
        let responseData = try! JSONEncoder().encode(errorResponse)

        MockURLProtocol.mockResponseData = responseData
        MockURLProtocol.mockError = nil

        let expectation = self.expectation(description: "register completes")

        let request = RegisterRequest(first_name: "Ana", last_name: "Gómez", email: "ana@mail.com", password: "123456", confirm_password: "123456")

        repository.register(user: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Correo ya registrado")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testRegisterHandlesNetworkError() {
        let networkError = NSError(domain: "Network", code: -1009, userInfo: [NSLocalizedDescriptionKey: "Sin conexión"])
        
        MockURLProtocol.mockError = networkError
        MockURLProtocol.mockResponseData = nil

        let expectation = self.expectation(description: "register completes")

        let request = RegisterRequest(first_name: "Ana", last_name: "Gómez", email: "ana@mail.com", password: "123456", confirm_password: "123456")

        repository.register(user: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Sin conexión")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
