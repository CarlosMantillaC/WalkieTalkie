//
//  ListUsersRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ListUsersRepositoryTests: XCTestCase {
    var repository: ListUsersRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        session = URLSession(configuration: config)
        repository = ListUsersRepository(session: session)

        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubError = nil
        StubURLProtocol.stubResponse = nil
    }

    override func tearDown() {
        repository = nil
        session = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectedUsers = ["user1", "user2"]
        let responseData = try! JSONEncoder().encode(expectedUsers)
        
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "fetchUsers completes with success")

        repository.fetchUsers(for: "test-channel") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users, expectedUsers)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchUsersFailureNetworkError() {
        let networkError = NSError(domain: "NetworkError", code: 123, userInfo: nil)
        StubURLProtocol.stubError = networkError
        
        let expectation = self.expectation(description: "fetchUsers completes with network error")

        repository.fetchUsers(for: "test-channel") { result in
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
    
    func testFetchUsersFailureInvalidJSON() {
        StubURLProtocol.stubResponseData = Data("invalid json".utf8)
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "fetchUsers completes with InvalidJSON error")

        repository.fetchUsers(for: "test-channel") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testFetchUsersFailureTokenExpiration() {
        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 401, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Token expiration handler is called")
        
        let observer = NotificationCenter.default.addObserver(forName: .tokenExpired, object: nil, queue: nil) { _ in
            expectation.fulfill()
        }

        repository.fetchUsers(for: "test-channel") { result in
            XCTFail("Completion handler should not be called if token expiration is handled")
        }

        waitForExpectations(timeout: 1)
        NotificationCenter.default.removeObserver(observer)
    }
}
