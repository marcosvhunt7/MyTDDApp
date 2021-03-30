//
//  URLProtocolMock.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 30/03/21.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = MockURLProtocol.testURLs[url] {
                self.client?.urlProtocol(self, didLoad: data)
            }
        }

        if let response = MockURLProtocol.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }

        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {

    }
}
