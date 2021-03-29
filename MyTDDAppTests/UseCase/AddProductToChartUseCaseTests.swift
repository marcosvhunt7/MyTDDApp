//
//  AddProductToChartUseCaseTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest
@testable import MyTDDApp

class AddProductToChartUseCaseTests: XCTestCase {
    func testAddTwoProductsToChartOneByOne() throws {
        let useCase = AddProductToChartUseCase(service: ChartService(Chart(products: [])))

        _ = useCase.execute(Product(id: UUID(), name: "Name", description: "Desc", price: 10.0))
        let chart = useCase.execute(Product(id: UUID(), name: "Name", description: "Desc", price: 10.0))

        XCTAssertEqual(chart.products.count, 2)
    }

    func testAddTwoProductsToChartInaRow() throws {
        let products = [Product(id: UUID(), name: "Name", description: "Desc", price: 10.0), Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)]
        let useCase = AddProductToChartUseCase(service: ChartService(Chart(products: [])))

        XCTAssertEqual(useCase.execute(products).products.count, 2)
    }
}
