//
//  ApiError.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 13/09/2025.
//

enum ApiError: Error {
    case badRequest(String)
    case unauthorized(String)
    case forbidden(String)
    case notFound(String)
    case methodNotAllowed(String)
    case conflict(String)
    case internalServerError(String)
    case invalidResponse(String)
}
