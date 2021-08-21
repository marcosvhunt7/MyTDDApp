//
//  ChartService.swift
//  MyTDDApp (iOS)
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import Foundation

protocol ChartServiceProtocol {
    var chart: ChartProtocol { get }
    
    func add(_ product: ProductProtocol) -> ChartProtocol
    func add(_ products: [ProductProtocol]) -> ChartProtocol
    func remove(_ product: ProductProtocol) -> ChartProtocol
    func remove(_ products: [ProductProtocol]) -> ChartProtocol
}

class ChartService: ChartServiceProtocol {
    var chart: ChartProtocol
    
    init(_ chart: ChartProtocol) {
        self.chart = chart
    }
    
    func add(_ product: ProductProtocol) -> ChartProtocol {
        let products = chart.products + [product]
        chart = Chart(products: products)
        return chart
    }
    
    func add(_ products: [ProductProtocol]) -> ChartProtocol {
        let products = chart.products + products
        chart = Chart(products: products)
        return chart
    }
    
    func remove(_ product: ProductProtocol) -> ChartProtocol {
        var chartPproducts = chart.products
        chartPproducts.removeAll { $0.id == product.id }
        chart = Chart(products: chartPproducts)
        return chart
    }
    
    func remove(_ products: [ProductProtocol]) -> ChartProtocol {
        var chartPproducts = chart.products
        chartPproducts.removeAll { chartProduct -> Bool in
            return products.contains { $0.id == chartProduct.id }
        }
        chart = Chart(products: chartPproducts)
        return chart
    }

}
