//
//  AuthServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//
import Foundation

struct AuthServiceImpl: AuthService {
    func login(email: String, password: String) async throws -> Void {
        let requestBody = LoginRequest(email: email, password: password)
        let requestConfig = HttpRequestConfig(requiresAuth: false)
        let token : String
        do{
            let response: LoginResponse = try await ApiClient.send(
                endpoint: "User/Authenticate",
                requestBody: requestBody,
                config: requestConfig
            )
            token = response.accessToken
        } catch {
            throw error
        }
        
        KeychainWrapper.remove("accessToken")
        KeychainWrapper.set(token, forKey: "accessToken")
    }
}
