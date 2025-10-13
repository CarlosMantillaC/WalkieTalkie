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

    func testFetchChannelsSuccessResponse() {
        let mockChannels = [
            Channel(name: "Channel 1", isPrivate: false, maxUsers: 100),
            Channel(name: "Channel 2", isPrivate: true, maxUsers: 20)
        ]
        let responseData = try! JSONEncoder().encode(mockChannels)

        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubError = nil

        let expectation = self.expectation(description: "fetchChannels completes")

        repository.fetchChannels { result in
            switch result {
            case .success(let channels):
                XCTAssertEqual(channels.count, 2)
                XCTAssertEqual(channels[0].name, "Channel 1")
                XCTAssertEqual(channels[1].name, "Channel 2")
                XCTAssertEqual(channels[1].isPrivate, true)
                XCTAssertEqual(channels[1].maxUsers, 20)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchChannelsReturnsInvalidJSONError() {
        let invalidJSON = ["invalid": "data"]
        let responseData = try! JSONEncoder().encode(invalidJSON)

        StubURLProtocol.stubResponseData = responseData
        StubURLProtocol.stubError = nil

        let expectation = self.expectation(description: "fetchChannels completes")

        repository.fetchChannels { result in
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

    func testFetchChannelsHandlesNetworkError() {
        let networkError = NSError(domain: "Network", code: -1009, userInfo: [NSLocalizedDescriptionKey: "Sin conexión"])

        StubURLProtocol.stubError = networkError
        StubURLProtocol.stubResponseData = nil

        let expectation = self.expectation(description: "fetchChannels completes")

        repository.fetchChannels { result in
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
