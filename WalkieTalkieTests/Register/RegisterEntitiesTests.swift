//
//  RegisterEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterEntitiesTests: XCTestCase {
    
    func testRegisterRequestInitialization() {
        let first_name = "Carlos"
        let last_name = "Mantilla"
        let email = "carlos@mail.com"
        let password = "123456"
        let confirm_password = "123456"
        
        let registerRequest = RegisterRequest(
            first_name: first_name,
            last_name: last_name,
            email: email,
            password: password,
            confirm_password: confirm_password
        )
        
        XCTAssertEqual(registerRequest.first_name, first_name)
        XCTAssertEqual(registerRequest.last_name, last_name)
        XCTAssertEqual(registerRequest.email, email)
        XCTAssertEqual(registerRequest.password, registerRequest.confirm_password)
    }
    
    func testRegisterRequestEncodingToJson() throws {
        let request = RegisterRequest(
            first_name: "Carlos",
            last_name: "Mantilla",
            email: "carlos@test.com",
            password: "123456",
            confirm_password: "123456"
        )
        
        let jsonData = try JSONEncoder().encode(request)
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
        
        let decoded = try JSONDecoder().decode(RegisterRequest.self, from: json)
        
        XCTAssertEqual(decoded.first_name, "Carlos")
        XCTAssertEqual(decoded.last_name, "Mantilla")
        XCTAssertEqual(decoded.email, "carlos@test.com")
        XCTAssertEqual(decoded.password, decoded.confirm_password)
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
