//
//  AddProductToChartUseCase.swift
//  MyTDDApp (iOS)
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import Foundation

protocol AddProductToChartUseCaseProtocol {
    var service: ChartServiceProtocol { get }

    func execute(_ product: ProductProtocol) -> ChartProtocol
    func execute(_ products: [ProductProtocol]) -> ChartProtocol
}

struct AddProductToChartUseCase: AddProductToChartUseCaseProtocol {
    let service: ChartServiceProtocol

    func execute(_ product: ProductProtocol) -> ChartProtocol {
        return service.add(product)
    }

    func execute(_ products: [ProductProtocol]) -> ChartProtocol {
        return service.add(products)
    }
}
