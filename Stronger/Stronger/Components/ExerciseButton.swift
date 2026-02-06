//
//  ExerciseButton.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

import SwiftUI

struct ExerciseButton: View {
    public let id: Int64
    public let title: String
    public let imageUri: String
    @ObservedObject var viewModel: WorkoutPlanCreateViewModel
    
    @State var isSelected = false
    
    private func updateSelectedState() -> Void {
        viewModel.onExerciseSelected(id: id){
            isSelected = !isSelected
        }
    }
    
    var body: some View {
        
        Button (action: updateSelectedState) {
            VStack (spacing: 10) {
                HStack {
                    Text(title)
                        .font(.caption)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundStyle(.black)
                    
                    if(isSelected){
                        Image(systemName: "checkmark.circle")
                    }
                }
                
                
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
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 2, x: 0, y: -1)
        }
        
    }
}
