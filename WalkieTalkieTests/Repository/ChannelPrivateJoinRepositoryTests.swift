//
//  ChannelPrivateJoinRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelPrivateJoinRepositoryTests: XCTestCase {
    var repository: ChannelPrivateJoinRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        session = URLSession(configuration: config)
        repository = ChannelPrivateJoinRepository(session: session)

        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubError = nil
        StubURLProtocol.stubResponse = nil
    }

    override func tearDown() {
        repository = nil
        session = nil
        super.tearDown()
    }

    func testJoinChannelSuccess() {
        let expectedResponse = ChannelPrivateJoinResponse(id: 1, isPrivate: true, maxUsers: 10, message: "Joined channel", name: "test")
        let responseData = try! JSONEncoder().encode(expectedResponse)
        
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "joinChannel completes with success")

        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")
        repository.joinChannel(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.id, expectedResponse.id)
                XCTAssertEqual(response.name, expectedResponse.name)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testJoinChannelFailureAPIError401() {
        let errorResponse = ChannelPrivateJoinAPIErrorResponse(error: "PIN incorrecto")
        let responseData = try! JSONEncoder().encode(errorResponse)
        
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 401, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "joinChannel completes with API error 401")

        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")
        repository.joinChannel(request: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "PIN incorrecto")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testJoinChannelFailureAPIError400() {
        let errorResponse = ChannelPrivateJoinAPIErrorResponse(error: "Bad Request")
        let responseData = try! JSONEncoder().encode(errorResponse)
        
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "joinChannel completes with API error 400")

        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")
        repository.joinChannel(request: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Bad Request")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testJoinChannelFailureNetworkError() {
        let networkError = NSError(domain: "NetworkError", code: 123, userInfo: nil)
        StubURLProtocol.stubError = networkError
        
        let expectation = self.expectation(description: "joinChannel completes with network error")

        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")
        repository.joinChannel(request: request) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "NetworkError")
                XCTAssertEqual((error as NSError).code, 123)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testJoinChannelFailureTokenExpiration() {
        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 401, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Token expiration handler is called")
        
        let observer = NotificationCenter.default.addObserver(forName: .tokenExpired, object: nil, queue: nil) { _ in
            expectation.fulfill()
        }

        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")
        repository.joinChannel(request: request) { result in
            XCTFail("Completion handler should not be called if token expiration is handled")
        }

        waitForExpectations(timeout: 1)
        NotificationCenter.default.removeObserver(observer)
    }
}
