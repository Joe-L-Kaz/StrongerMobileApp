//
//  ApiClient.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//
import Foundation

struct ApiClient {
    private  static let baseUrl = "http://localhost:5020/api/"

    public static func send<TRequest: Encodable, TResponse: Decodable>(
        endpoint: String,
        method: String = "POST",
        requestBody: TRequest?,
        config: HttpRequestConfig = HttpRequestConfig()
    ) async throws -> TResponse {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Set Content-Type
        request.setValue(config.contentType, forHTTPHeaderField: "Content-Type")
        
        // Bearer token
        if config.requiresAuth, let token = KeychainWrapper.get("accessToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add custom headers
        for (key, value) in config.additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        return try await execute(request: request)
    }
    
    public static func send<TResponse: Decodable>(
        endpoint: String,
        method: String = "GET",
        config: HttpRequestConfig = HttpRequestConfig()
    ) async throws -> TResponse {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Set Content-Type
        request.setValue(config.contentType, forHTTPHeaderField: "Content-Type")

        // Bearer token
        if config.requiresAuth == true, let token = KeychainWrapper.get("accessToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Add custom headers
        for (key, value) in config.additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return try await execute(request: request)
    }
    
    private static func execute<TResponse: Decodable>(request: URLRequest) async throws -> TResponse {
        let (data, response) = try await URLSession.shared.data(for: request)
        
#if DEBUG
        if let urlResponse = response as? HTTPURLResponse{
            print(urlResponse.statusCode)
            print(urlResponse)
        }
#endif // DEBUG
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if let failureResponse = response as? HTTPURLResponse {
                    switch failureResponse.statusCode {
                    case 400:
                        throw ApiError.badRequest("Request could not be processed")
                    
                    case 401:
                        throw ApiError.unauthorized("You are not authorized to perform this action")
                        
                    case 403:
                        throw ApiError.forbidden("This action is forbidden")
                        
                    case 404:
                        throw ApiError.notFound("Resource not found")
                        
                    case 405:
                        throw ApiError.methodNotAllowed("Method not allowed")
                        
                    case 409:
                        throw ApiError.conflict("Resource already exists")
                    
                    case 500:
                        throw ApiError.internalServerError("Api encountered an internal error")
                        
                    default:
                        throw ApiError.internalServerError("Api encountered an internal error")
                    }
                } else {
                    throw ApiError.internalServerError("Api encountered an internal error")
                }
        }
        do{
            let jsonData = try JSONDecoder().decode(TResponse.self, from: data)
            return jsonData
        } catch {
            throw ApiError.invalidResponse("The response object does not match the JSON data return from the API")
        }
    }
        
}
