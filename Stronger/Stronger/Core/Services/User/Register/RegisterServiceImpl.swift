//
//  RegisterServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//

import Foundation

struct RegisterServiceImpl: RegisterService {
    func register(forename: String, surname: String, dob: Date, email: String, password: String) async throws {
        let requestBody = RegisterRequest(
            forename: forename, surname: surname, dob: isoDateOnly(from: dob), email: email, password: password
        )
        let config = HttpRequestConfig(requiresAuth: false)
        let id: UUID
        
        do{
            let response : RegisterResponse = try await ApiClient.send(
                endpoint: "User",
                requestBody: requestBody,
                config: config
            )
            id = response.id
            print(id)
        } catch {
            throw error
        }
    }
}
