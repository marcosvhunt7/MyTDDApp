//
//  NetworkManager.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 29/03/21.
//

import Foundation

protocol NetworkManagerProtocol {
    associatedtype T
    func load(completion: (Result<T?, Error>) -> Void)
}

struct NetworkManager<U>: NetworkManagerProtocol {
    typealias T = U

    func load(completion: (Result<U?, Error>) -> Void) {
        completion(.success(nil))
    }
}
