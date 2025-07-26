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

        // Encode body if present
        if let body = requestBody {
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
            throw NSError(domain: "Api", code: 1, userInfo: [NSLocalizedDescriptionKey: responseBody])
        }

        return try JSONDecoder().decode(TResponse.self, from: data)
    }
}
