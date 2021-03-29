//
//  ProductAPITests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 29/03/21.
//

import XCTest
@testable import MyTDDApp

class NetworkTests: XCTestCase {

    func testFetchFromNetworkWithNil() {
        let api = NetworkManager<String>()

        api.load(completion: { result in
            let loaded = try? result.get()

            XCTAssertNil(loaded)
        })
    }
}
