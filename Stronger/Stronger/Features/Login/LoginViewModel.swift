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
    
    func login(completeion: @escaping (Bool) -> Void) async -> Void {
        isLoading = true
        do {
            try await authService.login(email: email, password: password)
        } catch {
            isLoading = false
            print(error)
            return
        }
        isLoading = false
        completeion(true)
    }
}
