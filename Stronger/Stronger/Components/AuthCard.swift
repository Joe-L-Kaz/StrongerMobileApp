//
//  AuthCard.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//
import SwiftUI

struct AuthCard<Content: View>: View {
    @Binding var isLoading: Bool
    var actionButtonLabel: String
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Lets get you started:")
                .bold(true)
                .font(.headline)
            
            content()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 5, x: 0, y: -1)
    }
}
