//
//  LoginViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    private let _authService: AuthService
    
    init(authService: AuthService = AuthServiceImpl()) {
        self._authService = authService
    }
    
    func login() async -> String? {
        isLoading = true
        do {
            let result = try await _authService.login(email: email, password: password)
            isLoading = false
            return result
        } catch {
            isLoading = false
            print(error)
            return nil
        }
    }
}
