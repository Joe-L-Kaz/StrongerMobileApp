//
//  RegisterViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//
import Foundation

@MainActor
final class RegisterViewModel: ObservableObject{
    @Published var forename: String = ""
    @Published var surname: String = ""
    @Published var dob: Date = Date()
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var step: Int = 1
    
    private let registerService: RegisterService
    
    init(registerService: RegisterService = RegisterServiceImpl()) {
        self.registerService = registerService
    }
    
    
    public func register(forename: String, surname: String, dob: Date, email: String, password: String, confirmPassword: String) async -> Void {
        if password != confirmPassword {
            return
        }
        
        isLoading = true;
        do{
            try await registerService.register(forename: forename, surname: surname, dob: dob, email: email, password: password)
        } catch {
            isLoading = false
            print(error)
            return
        }
        isLoading = false
    }
    
    public func advanceStep() -> Void {
        if formIsPartiallyFilled() {
            return
        }
            
        step += 1
    }
    
    private func formIsPartiallyFilled() -> Bool {
        
        return (
            forename.isEmpty ||
            surname.isEmpty ||
            email.isEmpty
        )
    }
}
