//
//  LoginEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginEntitiesTests: XCTestCase {
    
    func testLoginRequestInitialization() {
        let email = "test@mail.com"
        let password = "123456"
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        XCTAssertEqual(loginRequest.email, email)
        XCTAssertEqual(loginRequest.password, password)
    }
    
    func testLoginRequestEncodingToJson() throws {
        let request = LoginRequest(email: "test@mail.com", password: "123456")
        
        let jsonData = try JSONEncoder().encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"email\":\"test@mail.com\"") ?? false)
        XCTAssertTrue(jsonString?.contains("\"password\":\"123456\"") ?? false)
    }
    
    func testLoginRequestDecodingFromJson() throws {
        let json = """
            {
                "email": "test@mail.com",
                "password": "123456"
            }
            """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(LoginRequest.self, from: json)
        
        XCTAssertEqual(decoded.email, "test@mail.com")
        XCTAssertEqual(decoded.password, "123456")
    }
    
    func testLoginResponseInitialization() {
        let token = "1234abc"
        
        let loginResponse = LoginResponse(token: token)
        
        XCTAssertEqual(loginResponse.token, token)
    }
    
    func testLoginResponseEncodingToJson() throws {
        let request = LoginResponse(token: "1234abc")
        
        let jsonData = try JSONEncoder().encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"token\":\"1234abc\"") ?? false)
    }
    
    func testLoginResponseDecodingFromJson() throws {
        let json = """
            {
                "token": "1234abc"
            }
            """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(LoginResponse.self, from: json)
        
        XCTAssertEqual(decoded.token, "1234abc")
    }
    
    func testLoginErrorResponseInitialization() {
        let error = "error"
        
        let loginErrorResponse = LoginAPIErrorResponse(error: error)
        
        XCTAssertEqual(loginErrorResponse.error, error)
    }
    
    func testLoginErrorResponseEncodingToJson() throws {
        let request = LoginAPIErrorResponse(error: "error")
        
        let jsonData = try JSONEncoder().encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        XCTAssertTrue(jsonString?.contains("\"error\":\"error\"") ?? false)
    }
    
    func testLoginErrorResponseDecodingFromJson() throws {
        let json = """
            {
                "error": "error"
            }
            """.data(using: .utf8)!
        
        let decoded = try JSONDecoder().decode(LoginAPIErrorResponse.self, from: json)
        
        XCTAssertEqual(decoded.error, "error")
    }
}
