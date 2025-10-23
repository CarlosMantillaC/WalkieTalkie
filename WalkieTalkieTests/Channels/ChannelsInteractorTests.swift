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
        let publicChannels = [Channel(name: "Public1", isPrivate: false, maxUsers: 10)]
        let privateChannels = [Channel(name: "Private1", isPrivate: true, maxUsers: 5)]
        mockRepository.publicChannelsResult = .success(publicChannels)
        mockRepository.privateChannelsResult = .success(privateChannels)

        interactor.loadChannels()

        let expectation = XCTestExpectation(description: "Wait for async presenter call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.mockPresenter.publicChannels?.count, 1)
            XCTAssertEqual(self.mockPresenter.publicChannels?.first?.name, "Public1")
            XCTAssertEqual(self.mockPresenter.privateChannels?.count, 1)
            XCTAssertEqual(self.mockPresenter.privateChannels?.first?.name, "Private1")
            XCTAssertNil(self.mockPresenter.receivedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testLoadChannelsFailure() {
        let expectedError = NSError(domain: "Test", code: 123, userInfo: nil)
        mockRepository.publicChannelsResult = .failure(expectedError)
        mockRepository.privateChannelsResult = .success([])

        interactor.loadChannels()

        let expectation = XCTestExpectation(description: "Wait for async presenter error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.mockPresenter.receivedError as NSError?, expectedError)
            XCTAssertNil(self.mockPresenter.publicChannels)
            XCTAssertNil(self.mockPresenter.privateChannels)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
