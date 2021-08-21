//
//  AddProductToChartUseCaseTests.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import XCTest
@testable import MyTDDApp

class RemoveProductToChartUseCaseTests: XCTestCase {
    func testRemoveTwoProductsToChartOneByOne() throws {
        let products = [Product(id: UUID(), name: "Name", description: "Desc", price: 10.0), Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)]
        let useCase = RemoveProductToChartUseCase(service: ChartService(Chart(products: products)))

        _ = useCase.execute(products[0])
        let chart = useCase.execute(products[1])

        XCTAssertEqual(chart.products.count, 0)
    }

    func testRemoveTwoProductsToChartInaRow() throws {
        let products = [Product(id: UUID(), name: "Name", description: "Desc", price: 10.0), Product(id: UUID(), name: "Name", description: "Desc", price: 10.0)]
        let useCase = RemoveProductToChartUseCase(service: ChartService(Chart(products: products)))

        XCTAssertEqual(useCase.execute(products).products.count, 0)
    }
}
