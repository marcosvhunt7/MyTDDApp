//
//  ProductTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest

import XCTest
@testable import MyTDDApp

class ProductTests: XCTestCase {

//    override func setUpWithError() throws {}
//
//    override func tearDownWithError() throws {}
    
    func testProduct() throws {
        let product = Product(name: "Name", description: "Desc", price: 10.0)
        
        XCTAssertEqual(product.name, "Name")
        XCTAssertEqual(product.description, "Desc")
        XCTAssertEqual(product.price, 10.0)
    }
}
