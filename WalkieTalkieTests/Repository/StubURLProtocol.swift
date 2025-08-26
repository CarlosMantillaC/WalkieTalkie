//
//  MockURLProtocol.swift
//  WalkieTalkieTests
//

//

import Foundation

class StubURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var stubError: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = StubURLProtocol.stubError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if let data = StubURLProtocol.stubResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
