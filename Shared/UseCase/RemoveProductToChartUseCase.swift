//
//  RemoveProductToChartUseCase.swift
//  MyTDDApp (iOS)
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import Foundation

protocol RemoveProductToChartUseCaseProtocol {
    var service: ChartServiceProtocol { get }

    func execute(_ product: ProductProtocol) -> ChartProtocol
    func execute(_ products: [ProductProtocol]) -> ChartProtocol
}

struct RemoveProductToChartUseCase: RemoveProductToChartUseCaseProtocol {
    let service: ChartServiceProtocol

    func execute(_ product: ProductProtocol) -> ChartProtocol {
        return service.remove(product)
    }

    func execute(_ products: [ProductProtocol]) -> ChartProtocol {
        return service.remove(products)
    }
}
