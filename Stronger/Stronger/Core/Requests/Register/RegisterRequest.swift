//
//  RegisterRequest.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//
import Foundation

struct RegisterRequest: Codable {
    let forename: String
    let surname: String
    let dob: String
    let email: String
    let password: String
}
