//
//  ProductAPITests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 29/03/21.
//

import XCTest
import Combine
@testable import MyTDDApp

class APITests: XCTestCase {
    private static let baseURL: URL = URL(string: "http://localhost:8080")!

    func testLoadWithSuccess() {
        setupHTTPMock(testURLs: [APITests.baseURL: Mocks.validResponseData], response: Mocks.validResponse, error: nil)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        let session = URLSession(configuration: config)

        let api = SomeAPI(session: session)

        let value = try? awaitValue(api.load())

        XCTAssertEqual(value?.name, Mocks.mockResponse.name)
    }

    func testLoadWithNotAuthorized() {
        setupHTTPMock(testURLs: [APITests.baseURL: Mocks.validResponseData], response: Mocks.invalidResponse401, error: APIError.unauthorized)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        let session = URLSession(configuration: config)

        let api = SomeAPI(session: session)

        let error = try? awaitError(api.load())

        guard let apiArror = error as? APIError else {
            print(error?.localizedDescription)
            XCTFail("The error should be a kind of APIError")
            return
        }
        XCTAssertEqual(apiArror, APIError.unauthorized)
    }

    // MARK: - HELPERS

    func setupHTTPMock(testURLs: [URL?: Data], response: URLResponse?, error: Error?) {
        MockURLProtocol.response = response
        MockURLProtocol.testURLs = testURLs
        MockURLProtocol.error = error
    }

    private class Mocks {
        static let mockResponse = MockResponseModel(name: "name")

        static let validResponseData = "{\"name\":\"\(Mocks.mockResponse.name)\"}".data(using: .utf8)!

        static let invalidResponse = URLResponse(url: baseURL,
                                          mimeType: nil,
                                          expectedContentLength: 0,
                                          textEncodingName: nil)

        static let validResponse = HTTPURLResponse(url: baseURL,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)

        static let invalidResponse300 = HTTPURLResponse(url: baseURL,
                                                 statusCode: 300,
                                                 httpVersion: nil,
                                                 headerFields: nil)
        static let invalidResponse401 = HTTPURLResponse(url: baseURL,
                                                 statusCode: 401,
                                                 httpVersion: nil,
                                                 headerFields: nil)

        static let networkError = NSError(domain: "NSURLErrorDomain",
                                   code: -1004, //kCFURLErrorCannotConnectToHost
                                   userInfo: nil)

    }

    private struct MockResponseModel: Codable {
        let name: String
    }

    private struct SomeAPI: APIProtocol {

        typealias T = MockResponseModel

        var session: URLSession

        var urlRequest: URLRequest {
            return URLRequest(url: baseURL)
        }
    }
}


