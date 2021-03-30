//
//  NetworkManager.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 29/03/21.
//

import Foundation

protocol APIProtocol {
    associatedtype T: Codable

    var session: URLSession { get }
    func load(completion: @escaping (Result<T?, Error>) -> Void)
}

struct API<U: Codable>: APIProtocol {
    let session: URLSession

    let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!

    typealias T = U

    func load(completion: @escaping (Result<U?, Error>) -> Void) {
        let cancellable = session
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                print ("Received completion: \($0).")

            },
            receiveValue: { user in
                completion(.success(user))
            })
    }
}
