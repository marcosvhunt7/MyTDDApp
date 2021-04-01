//
//  XCTestCaseExtension.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 30/03/21.
//

import Foundation
import XCTest
import Combine

extension XCTestCase {
    func awaitValue<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        result = .failure(error)
                    case .finished:
                        break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }

    func awaitError<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Error? {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher fail")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        result = .failure(error)
                    case .finished:
                        break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        switch unwrappedResult {
            case .failure(let error):
                return error
            default:
                XCTFail("Should return an error")
                return nil
        }
    }
}
