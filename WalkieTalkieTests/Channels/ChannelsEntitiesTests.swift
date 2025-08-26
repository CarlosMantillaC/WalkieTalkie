//
//  ChannelsEntitiesTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsEntitiesTests: XCTestCase {
    
    func testChannelsInitialization() {
        let name = "canal 1"
        
        let channel = Channel(name: name)
        
        XCTAssertEqual(channel.name, name)
    }
}
