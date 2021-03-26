//
//  ChartServiceTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest
@testable import MyTDDApp

class ChartServiceTests: XCTestCase {

    func testAddOneProductToChart() throws {
        let chartService = ChartService(Chart(products: []))
        
        XCTAssertEqual(chartService.add(Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0)).products.count, 1)
        XCTAssertEqual(chartService.chart.products.count, 1)
    }
    
    func testAddTwoProductToChart() throws {
        let products = [Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0)]
        let chartService = ChartService(Chart(products: []))
        
        XCTAssertEqual(chartService.add(products).products.count, 2)
        XCTAssertEqual(chartService.chart.products.count, 2)
    }
    
    func testRemoveOneProduct() {
        let products = [Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0)]
        let chartService = ChartService(Chart(products: products))

        XCTAssertEqual(chartService.remove(products[0]).products.count, 1)
    }
    
    func testRemoveTwoProduct() {
        let products = [Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0),
                        Product(id: UUID().uuidString, name: "Name", description: "Desc", price: 0.0)]
        let chartService = ChartService(Chart(products: products))

        let productsToRemove: [Product] = Array(products[0...1])
        XCTAssertEqual(chartService.remove(productsToRemove).products.count, 3)
    }
}
