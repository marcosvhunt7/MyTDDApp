//
//  Product.swift
//  MyTDDApp
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import Foundation

protocol ProductProtocol {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
    var price: Double { get }
}

struct Product: ProductProtocol {
    let id: UUID
    let name: String
    let description: String
    let price: Double
}
