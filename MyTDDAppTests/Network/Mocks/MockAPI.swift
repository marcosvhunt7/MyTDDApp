//
//  MockAPI.swift
//  MyTDDAppTests
//
//  Created by Marcos Vinicius da Cunha Brito on 31/03/21.
//

import Foundation
import Combine
@testable import MyTDDApp

struct MockResponseModel: Codable {
    let name: String
}

struct MockAPI: APIProtocol {
    private let url: URL = URL(fileURLWithPath: "")

    typealias T = MockResponseModel

    var session: APIProvider

    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
}
