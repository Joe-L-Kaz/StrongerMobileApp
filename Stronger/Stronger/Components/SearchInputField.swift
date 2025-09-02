//
//  SearchInputField.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct SearchInputField: View {
    @Binding var value: String
    public let placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $value)
                .textInputAutocapitalization(.never)
                .padding(8)

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
    
}
