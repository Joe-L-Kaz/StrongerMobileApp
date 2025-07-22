//
//  AuthService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//

protocol AuthService{
    func login(email: String, password: String) async throws -> String
}
