//
//  LoadingButton.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//

import SwiftUI

struct LoadingButton<Label: View>: View {
    @Binding var isLoading: Bool
    var onSubmit: () -> Void
    var label: () -> Label
    
    
    var body: some View {
        Button(action: {
            onSubmit()
        }) {
            if isLoading {
                HStack {
                    ProgressView()
                        .tint(Color.white)
                    
                    label()
                        .foregroundColor(Color.white)
                }
                .padding(10)
            } else {
                label()
                    .padding(10)
                    .foregroundColor(Color.white)
            }
        }
        .background(Color.black)
        .cornerRadius(5)
    }
}
