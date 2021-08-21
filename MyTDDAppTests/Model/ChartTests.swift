//
//  ChartTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest
@testable import MyTDDApp

class ChartTests: XCTestCase {
    
    func testEmptyChart() throws {
        let chart = Chart(products: [])
        
        XCTAssertEqual(chart.products.count, 0)
    }
    
    func testChartWithOndeProduct() {
        let chart = Chart(products: [Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)])
        
        XCTAssertEqual(chart.products.count, 1)
    }
}
