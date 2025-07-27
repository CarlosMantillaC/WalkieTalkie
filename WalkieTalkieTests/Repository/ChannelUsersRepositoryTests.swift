//
//  ChannelUsersRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelUsersRepositoryTests: XCTestCase {
    var repository: ChannelUsersRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        repository = ChannelUsersRepository(session: session)

        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockError = nil
    }

    override func tearDown() {
        repository = nil
        session = nil
        super.tearDown()
    }

    func testFetchUsersWithValidJSONReturnsUserList() {
        let expectedUsers = ["user1@example.com", "user2@example.com"]
        MockURLProtocol.mockResponseData = try? JSONEncoder().encode(expectedUsers)

        let expectation = self.expectation(description: "Wait for fetchUsers")

        repository.fetchUsers(for: "test-channel") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users, expectedUsers)
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetchUsersWithInvalidJSONReturnsInvalidJSONError() {
        MockURLProtocol.mockResponseData = Data("not a json array".utf8)
        let expectation = self.expectation(description: "Wait for fetchUsers")

        repository.fetchUsers(for: "test-channel") { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to invalid JSON, but got success")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, "InvalidJSON")
                XCTAssertEqual(error.code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetchUsersWithNetworkErrorReturnsError() {
        let expectedError = NSError(domain: "TestError", code: -999)
        MockURLProtocol.mockError = expectedError
        let expectation = self.expectation(description: "Wait for fetchUsers")

        repository.fetchUsers(for: "test-channel") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, expectedError.domain)
                XCTAssertEqual(error.code, expectedError.code)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
