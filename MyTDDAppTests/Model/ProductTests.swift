//
//  ProductTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest
@testable import MyTDDApp

class ProductTests: XCTestCase {
    func testProduct() throws {
        let product = Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)
        
        XCTAssertEqual(product.name, "Name")
        XCTAssertEqual(product.description, "Desc")
        XCTAssertEqual(product.price, 10.0)
    }
    
    func testProductUniqueCode() throws {
        let product1 = Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)
        let product2 = Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)
        
        XCTAssertNotEqual(product1.id, product2.id)
    }
}
