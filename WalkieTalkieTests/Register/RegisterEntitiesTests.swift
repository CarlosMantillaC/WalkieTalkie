//
//  RegisterEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterEntitiesTests: XCTestCase {
    
    func testRegisterRequestInitialization() {
        let firstName = "Carlos"
        let lastName = "Mantilla"
        let email = "carlos@mail.com"
        let password = "123456"
        let confirmPassword = "123456"
        
        let registerRequest = RegisterRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )
        
        XCTAssertEqual(registerRequest.firstName, firstName)
        XCTAssertEqual(registerRequest.lastName, lastName)
        XCTAssertEqual(registerRequest.email, email)
        XCTAssertEqual(registerRequest.password, registerRequest.confirmPassword)
    }
    
    func testRegisterRequestEncodingToJson() throws {
        let request = RegisterRequest(
            firstName: "Carlos",
            lastName: "Mantilla",
            email: "carlos@test.com",
            password: "123456",
            confirmPassword: "123456"
        )
        let encoder = NetworkService.shared.encoder
        let jsonData = try encoder.encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"first_name\":\"Carlos\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"last_name\":\"Mantilla\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"email\":\"carlos@test.com\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"password\":\"123456\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"confirm_password\":\"123456\"") ?? false)
    }
    
    func testRegisterRequestDecodingFromJson() throws {
        let json = """
          {
              "first_name": "Carlos",
              "last_name": "Mantilla",
              "email": "carlos@test.com",
              "password": "123456",
              "confirm_password": "123456"
          }
          """.data(using: .utf8)!
        
        let decoder = NetworkService.shared.decoder
        let decoded = try decoder.decode(RegisterRequest.self, from: json)
        
        XCTAssertEqual(decoded.firstName, "Carlos")
        XCTAssertEqual(decoded.lastName, "Mantilla")
        XCTAssertEqual(decoded.email, "carlos@test.com")
        XCTAssertEqual(decoded.password, decoded.confirmPassword)
    }
    
    func testRegisterResponseInitialization() {
        let message = "message"
        
        let registerResponse = RegisterResponse(message: message)
        
        XCTAssertEqual(registerResponse.message, message)
    }
    
    func testRegisterResponseEncodingToJson() throws {
        let request = RegisterResponse(message: "message")
        
        let jsonData = try JSONEncoder().encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"message\":\"message\"") ?? false)
    }
    
    func testRegisterResponseDecodingFromJson() throws {
        let json = """
            {
                "message": "message"
            }
            """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(RegisterResponse.self, from: json)
        
        XCTAssertEqual(decoded.message, "message")
    }
    
    func testRegisterErrorResponseInitialization() {
        let error = "error"
        
        let registerErrorResponse = RegisterAPIErrorResponse(error: error)
        
        XCTAssertEqual(registerErrorResponse.error, error)
    }
    
    func testRegisterErrorResponseEncodiginToJson() throws {
        let request = RegisterAPIErrorResponse(error: "error")
        
        let jsonData = try JSONEncoder().encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"error\":\"error\"") ?? false)
    }
    
    func testRegisterErrorResponseDecodingFromJson() throws {
        let json = """
            {
                "error": "error"
            }
            """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(RegisterAPIErrorResponse.self, from: json)
        
        XCTAssertEqual(decoded.error, "error")
    }
}
