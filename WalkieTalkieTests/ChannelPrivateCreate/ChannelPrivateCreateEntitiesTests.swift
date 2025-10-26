//
//  ChannelPrivateCreateEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateCreateEntitiesTests: XCTestCase {

    func testChannelPrivateCreateRequestEncoding() throws {
        let request = ChannelPrivateCreateRequest(name: "test", pin: "1234")

        let data = try JSONEncoder().encode(request)
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])

        XCTAssertEqual(dictionary["name"] as? String, "test")
        XCTAssertEqual(dictionary["pin"] as? String, "1234")
    }

    func testChannelPrivateCreateResponseDecoding() throws {
        let json = """
        {
            "id": 1,
            "isPrivate": true,
            "maxUsers": 10,
            "message": "Channel created",
            "name": "test"
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ChannelPrivateCreateResponse.self, from: json)

        XCTAssertEqual(response.id, 1)
        XCTAssertTrue(response.isPrivate)
        XCTAssertEqual(response.maxUsers, 10)
        XCTAssertEqual(response.message, "Channel created")
        XCTAssertEqual(response.name, "test")
    }

    func testChannelPrivateCreateAPIErrorResponseDecoding() throws {
        let json = """
        {
            "error": "Invalid PIN"
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ChannelPrivateCreateAPIErrorResponse.self, from: json)

        XCTAssertEqual(response.error, "Invalid PIN")
    }
}
