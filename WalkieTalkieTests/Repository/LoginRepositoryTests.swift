//
//  LoginRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginRepositoryTests: XCTestCase {
    var repository: LoginRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        session = URLSession(configuration: config)
        repository = LoginRepository(session: session)
    }

    func testLoginSuccessResponse() {
        let expectedToken = "abc123"
        let response = LoginResponse(accessToken: expectedToken, accessTokenExpiresIn: 3600, email: "", first_name: "", last_name: "", refreshToken: "", refreshTokenExpiresAt: "", user_id: 1)
        let responseData = try! JSONEncoder().encode(response)

        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubError = nil

        let expectation = self.expectation(description: "login completes")

        let request = LoginRequest(email: "correo@valido.com", password: "123456")

        repository.login(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.accessToken, expectedToken)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testLoginReturnsAPIError() {
        let errorResponse = LoginAPIErrorResponse(error: "Credenciales inválidas")
        let responseData = try! JSONEncoder().encode(errorResponse)

        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubError = nil

        let expectation = self.expectation(description: "login completes")

        let request = LoginRequest(email: "correo@valido.com", password: "incorrecta")

        repository.login(request: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Credenciales inválidas")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testLoginHandlesNetworkError() {
        let networkError = NSError(domain: "Network", code: -1009, userInfo: [NSLocalizedDescriptionKey: "Sin conexión"])
        
        StubURLProtocol.stubError = networkError
        StubURLProtocol.stubResponseData = nil

        let expectation = self.expectation(description: "login completes")

        let request = LoginRequest(email: "correo@valido.com", password: "123456")

        repository.login(request: request) { result in
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
