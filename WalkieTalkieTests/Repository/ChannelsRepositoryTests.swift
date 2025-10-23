//
//  ChannelsRepositoryTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsRepositoryTests: XCTestCase {
    var repository: ChannelsRepository!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        session = URLSession(configuration: config)
        repository = ChannelsRepository(session: session)
    }

    override func tearDown() {
        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubError = nil
        StubURLProtocol.stubResponse = nil
        repository = nil
        session = nil
        super.tearDown()
    }

    func testFetchPublicChannelsSuccess() {
        let mockChannels = [Channel(name: "Public Channel", isPrivate: false, maxUsers: 100)]
        let responseData = try! JSONEncoder().encode(mockChannels)
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPublicChannels completes with success")

        repository.fetchPublicChannels { result in
            switch result {
            case .success(let channels):
                XCTAssertEqual(channels.count, 1)
                XCTAssertEqual(channels.first?.name, "Public Channel")
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchPublicChannelsFailureInvalidJSON() {
        StubURLProtocol.stubResponseData = Data("Invalid JSON".utf8)
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPublicChannels completes with InvalidJSON error")

        repository.fetchPublicChannels { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "InvalidJSON")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchPublicChannelsFailureNetworkError() {
        let networkError = NSError(domain: "NetworkError", code: 123, userInfo: nil)
        StubURLProtocol.stubError = networkError
        let expectation = self.expectation(description: "fetchPublicChannels completes with network error")

        repository.fetchPublicChannels { result in
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
    
    func testFetchPublicChannelsFailureNoData() {
        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPublicChannels completes with NoData error")

        repository.fetchPublicChannels { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "InvalidJSON")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testFetchPrivateChannelsSuccess() {
        let mockChannels = [Channel(name: "Private Channel", isPrivate: true, maxUsers: 50)]
        let responseData = try! JSONEncoder().encode(mockChannels)
        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPrivateChannels completes with success")

        repository.fetchPrivateChannels { result in
            switch result {
            case .success(let channels):
                XCTAssertEqual(channels.count, 1)
                XCTAssertEqual(channels.first?.name, "Private Channel")
                XCTAssertTrue(channels.first?.isPrivate ?? false)
            case .failure(let error):
                XCTFail("Expected success, got failure with error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchPrivateChannelsFailureInvalidJSON() {
        StubURLProtocol.stubResponseData = Data("Invalid JSON".utf8)
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPrivateChannels completes with InvalidJSON error")

        repository.fetchPrivateChannels { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "InvalidJSON")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchPrivateChannelsFailureNetworkError() {
        let networkError = NSError(domain: "NetworkError", code: 456, userInfo: nil)
        StubURLProtocol.stubError = networkError
        let expectation = self.expectation(description: "fetchPrivateChannels completes with network error")

        repository.fetchPrivateChannels { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "NetworkError")
                XCTAssertEqual((error as NSError).code, 456)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testFetchPrivateChannelsFailureNoData() {
        StubURLProtocol.stubResponseData = nil
        StubURLProtocol.stubResponse = HTTPURLResponse(url: URL(string: APIConstants.baseURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = self.expectation(description: "fetchPrivateChannels completes with NoData error")

        repository.fetchPrivateChannels { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "InvalidJSON")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
