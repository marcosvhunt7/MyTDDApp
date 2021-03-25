//
//  Chart.swift
//  MyTDDApp (iOS)
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import Foundation

protocol ChartProtocol {
    var products: [ProductProtocol] { get }
}

struct Chart: ChartProtocol {
    var products: [ProductProtocol]
}
