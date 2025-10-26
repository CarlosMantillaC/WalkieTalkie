//
//  ChannelPrivateJoinEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class ChannelPrivateJoinEntitiesTests: XCTestCase {

    func testChannelPrivateJoinRequestEncoding() throws {
        let request = ChannelPrivateJoinRequest(name: "test", pin: "1234")

        let data = try JSONEncoder().encode(request)
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])

        XCTAssertEqual(dictionary["name"] as? String, "test")
        XCTAssertEqual(dictionary["pin"] as? String, "1234")
    }

    func testChannelPrivateJoinResponseDecoding() throws {
        let json = """
        {
            "id": 1,
            "isPrivate": true,
            "maxUsers": 10,
            "message": "Joined channel",
            "name": "test"
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ChannelPrivateJoinResponse.self, from: json)

        XCTAssertEqual(response.id, 1)
        XCTAssertTrue(response.isPrivate)
        XCTAssertEqual(response.maxUsers, 10)
        XCTAssertEqual(response.message, "Joined channel")
        XCTAssertEqual(response.name, "test")
    }

    func testChannelPrivateJoinAPIErrorResponseDecoding() throws {
        let json = """
        {
            "error": "Invalid PIN"
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ChannelPrivateJoinAPIErrorResponse.self, from: json)

        XCTAssertEqual(response.error, "Invalid PIN")
    }
}
