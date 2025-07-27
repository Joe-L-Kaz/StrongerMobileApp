//
//  RegisterService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//
import Foundation


protocol RegisterService {
    func register(forename: String, surname: String, dob: Date, email: String, password: String) async throws -> Void
}
