//
//  ChannelsInteractorTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class ChannelsInteractorTests: XCTestCase {
    var interactor: ChannelsInteractor!
    var mockRepository: MockChannelsRepository!
    var mockPresenter: MockChannelsInteractorOutput!

    override func setUp() {
        super.setUp()
        
        mockRepository = MockChannelsRepository()
        mockPresenter = MockChannelsInteractorOutput()
        interactor = ChannelsInteractor(repository: mockRepository)
        
        interactor.presenter = mockPresenter
    }
    
    func testLoadChannelsSuccess() {
        let mockChannels = [Channel(name: "General"), Channel(name: "Tech")]
        mockRepository.resultToReturn = .success(mockChannels)

        interactor.loadChannels()

        let expectation = XCTestExpectation(description: "Wait for async presenter call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.mockPresenter.loadedChannels?.count, 2)
            XCTAssertEqual(self.mockPresenter.loadedChannels?.first?.name, "General")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testLoadChannelsFailure() {
        let expectedError = NSError(domain: "Test", code: 123, userInfo: nil)
        mockRepository.resultToReturn = .failure(expectedError)

        interactor.loadChannels()

        let expectation = XCTestExpectation(description: "Wait for async presenter error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.mockPresenter.receivedError as NSError?, expectedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
