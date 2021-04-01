//
//  MockURLSession.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 30/03/21.
//

import Foundation
import Combine
@testable import MyTDDApp

class MockURLSession: APIProvider {
    static var response: URLResponse = HTTPURLResponse()
    static var data: Data = Data()
    static var error: URLError?

    func erasedDataTaskPublisher(for request: URLRequest) -> ErasedDataTaskPublisher {
        if let error = Self.error {
            return Result.failure(error).publisher.eraseToAnyPublisher()
        } else {
            return Result.success((data: Self.data, response: Self.response)).publisher.eraseToAnyPublisher()
        }
    }
}
