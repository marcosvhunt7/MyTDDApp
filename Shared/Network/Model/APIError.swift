//
//  APIError.swift
//  MyTDDApp (iOS)
//
//  Created by Marcos Vinicius da Cunha Brito on 30/03/21.
//

import Foundation


public enum APIError: Int, Error, Equatable {
    case badRequest = 400
    case badResponse
    case forbidden
    case internalServerError
    case internetNotReachable
    case methodNotAllowed
//    case serverError(statusCode: Int, errorCodes: [String], messages: [String])
    case requestTimeout
    case resourceNotFound
    case unauthorized
    case unknown
}

extension APIError {

    public static func error(fromStatusCode statusCode: Int, data: Data?) -> APIError {

        // Determine error from status code
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .resourceNotFound
            case 405: return .methodNotAllowed
            case 408: return .requestTimeout
            case 500: return .internalServerError
            default:  return .unknown
        }
    }
}
