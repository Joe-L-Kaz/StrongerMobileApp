//
//  AuthServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//
import Foundation

struct AuthServiceImpl: AuthService {
    func login(email: String, password: String) async throws -> String {
        guard let url = URL(string: "http://localhost:5020/api/User/Authenticate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
            print("API call failed. Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            print("Response body: \(responseBody)")
            throw NSError(domain: "Auth", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }
        
        struct LoginResponse: Decodable {
            let accessToken: String
        }
        
        let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
        print(decoded.accessToken);
        return decoded.accessToken
    }
}
