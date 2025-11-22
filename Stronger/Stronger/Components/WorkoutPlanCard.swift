//
//  WorkoutPlanCard.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

import SwiftUI

struct WorkoutPlanCard : View {
    let title: String
    let onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.system(size: 50))
            
            StaticButton(onSubmit: onSubmit) {
                Text("View")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 2, x: 0, y: -1)
    }
}
