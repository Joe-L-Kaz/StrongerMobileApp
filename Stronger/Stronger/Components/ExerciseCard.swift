//
//  ExerciseCard.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 03/09/2025.
//

import SwiftUI

struct ExerciseCard: View {
    public let title: String
    public let imageUri: String
    
    var body: some View {
        VStack (spacing: 10) {
            Text(title)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)
            
            AsyncImage(url: URL(string: imageUri)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 125, height: 100)
            .clipped()
            .cornerRadius(8)
            
            StaticButton(onSubmit: { }) {
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
