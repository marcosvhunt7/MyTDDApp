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

    func testLoadWithSuccess() {
        let api = setupAPI(data: Mocks.validResponseData, response: Mocks.validResponse, error: nil)
        let value = try? awaitValue(api.load())
        XCTAssertEqual(value?.name, Mocks.mockResponse.name)
    }

    func testLoadWithNotAuthorized() {
        let api = setupAPI(data: Data(), response: Mocks.unauthorizedResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.unauthorized)
    }

    func testLoadWithForbidden() {
        let api = setupAPI(data: Data(), response: Mocks.forbiddenResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.forbidden)
    }

    func testLoadWithNotFound() {
        let api = setupAPI(data: Data(), response: Mocks.resourceNotFoundResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.resourceNotFound)
    }

    func testLoadWithMethodNotAllowed() {
        let api = setupAPI(data: Data(), response: Mocks.methodNotAllowedResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.methodNotAllowed)
    }

    func testLoadWithRequestTimeout() {
        let api = setupAPI(data: Data(), response: Mocks.requestTimeoutResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.requestTimeout)
    }

    func testLoadWithInternalServerError() {
        let api = setupAPI(data: Data(), response: Mocks.internalServerErrorResponse, error: nil)
        let error = try? awaitError(api.load())
        let apiArror = castToAPIError(error)
        XCTAssertEqual(apiArror, APIError.internalServerError)
    }

    func testLoadWithSomeNetworkError() {
        let api = setupAPI(data: Data(), response: Mocks.internalServerErrorResponse, error: URLError(.unknown))
        let error = try? awaitError(api.load()) as? URLError
        XCTAssertEqual(error?.hashValue, URLError(.unknown).hashValue)
    }

    func testLoadWithInvalidResponse() {
        let api = setupAPI(data: Data(), response: Mocks.invalidResponse, error: nil)
        let error = try? awaitError(api.load()) as? URLError
        XCTAssertEqual(error?.hashValue, URLError(.badServerResponse).hashValue)
    }

    // MARK: - HELPERS

    private func castToAPIError(_ error: Error?) -> APIError {
        guard let apiArror = error as? APIError else {
            print(error?.localizedDescription ?? "")
            XCTFail("The error should be a kind of APIError")
            return .unknown
        }
        return apiArror
    }

    private func setupAPI(data: Data, response: URLResponse, error: URLError?) -> MockAPI {
        let mockSession = MockURLSession()
        MockURLSession.response = response
        MockURLSession.data = data
        MockURLSession.error = error
        return MockAPI(session: mockSession)
    }

    private class Mocks {
        static let baseURL: URL = URL(string: "http://localhost:8080")!

        static let mockResponse = MockResponseModel(name: "name")

        static let validResponseData = "{\"name\":\"\(Mocks.mockResponse.name)\"}".data(using: .utf8)!
        static let inValidResponseData = "{}".data(using: .utf8)!

        static let invalidResponse = URLResponse(url: baseURL,
                                                 mimeType: nil,
                                                 expectedContentLength: 0,
                                                 textEncodingName: nil)

        static let validResponse = generateResponse(code: 200)
        static let badRequestResponse = generateResponse(code: 400)
        static let unauthorizedResponse = generateResponse(code: 401)
        static let forbiddenResponse = generateResponse(code: 403)
        static let resourceNotFoundResponse = generateResponse(code: 404)
        static let methodNotAllowedResponse = generateResponse(code: 405)
        static let requestTimeoutResponse = generateResponse(code: 408)
        static let internalServerErrorResponse = generateResponse(code: 500)


        static let networkError = NSError(domain: "NSURLErrorDomain",
                                          code: -1004, //kCFURLErrorCannotConnectToHost
                                          userInfo: nil)

        static func generateResponse(code: Int) -> URLResponse {
            return HTTPURLResponse(url: baseURL,
                                   statusCode: code,
                                   httpVersion: nil,
                                   headerFields: nil)!
        }

    }
}


