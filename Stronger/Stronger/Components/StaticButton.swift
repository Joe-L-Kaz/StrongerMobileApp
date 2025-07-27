//
//  StaticButton.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//

import SwiftUI

struct StaticButton<Label: View>: View {
    var onSubmit: () -> Void
    var label: () -> Label
    
    var body: some View {
        Button(action: {
            onSubmit()
        }){
            label()
                .padding(10)
                .foregroundColor(Color.white)
        }
        .background(Color.black)
        .cornerRadius(5)
    }
}
