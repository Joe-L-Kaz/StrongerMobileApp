//
//  InputField.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct InputField: View {
    @Binding public var value: String
    public let placeholder: String
    public let isSecureTextEntry: Bool = false
    
    var body: some View {
        if isSecureTextEntry {
            SecureField(placeholder, text: $value)
                .textInputAutocapitalization(.never)
                .padding(5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        } else {
            TextField(placeholder, text: $value)
                .textInputAutocapitalization(.never)
                .padding(5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        }
    }
}
