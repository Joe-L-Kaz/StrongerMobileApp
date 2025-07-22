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
    
    private let authService: AuthService
    
    init(authService: AuthService = AuthServiceImpl()) {
        self.authService = authService
    }
    
    func login(completeion: @escaping (Bool) -> Void) async -> String? {
        isLoading = true
        do {
            let result = try await authService.login(email: email, password: password)
            isLoading = false
            completeion(true)
            return result
        } catch {
            isLoading = false
            print(error)
            return nil
        }
    }
}
