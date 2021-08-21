//
//  NetworkManager.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 29/03/21.
//

import Foundation
import Combine

protocol APIProvider {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    typealias ErasedDataTaskPublisher = AnyPublisher<APIResponse, URLError>

    func erasedDataTaskPublisher(for request: URLRequest) -> ErasedDataTaskPublisher
}

protocol APIProtocol {
    associatedtype T: Codable

    var session: APIProvider { get }
    var urlRequest: URLRequest { get }
    func load() -> AnyPublisher<T, Error>
}

extension APIProtocol {

    @discardableResult
    func load() -> AnyPublisher<T, Error> {
        let task = session
            .erasedDataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                guard httpResponse.statusCode == 200 else {
                    throw APIError.error(fromStatusCode: httpResponse.statusCode, data: element.data)
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        return task
    }
}
