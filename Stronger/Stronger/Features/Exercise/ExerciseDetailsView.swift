//
//  ExerciseDetailsView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

import SwiftUI

struct ExerciseDetailsView : View {
    let exercise: ExerciseResponse
    var body : some View {
        VStack ( alignment: .center, spacing: 10,) {
            Text(exercise.name)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
                .truncationMode(.tail)
            
            AsyncImage(url: URL(string: "http://localhost:5020/images/" + (exercise.imagePath ?? ""))) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 200)
            .clipped()
            .cornerRadius(8)
            
            Text(exercise.description)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Muscle Group(s)")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                
                Text("- " + exercise.primaryMuscleGroup.rawValue)
                    .font(.system(size: 18))
                
                if(exercise.secondaryMuscleGroup != nil){
                    Text("- " + exercise.secondaryMuscleGroup!.rawValue)
                        .font(.system(size: 18))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Force Type:")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    
                    Text(exercise.forceType.rawValue)
                        .font(.system(size: 18))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Exercise Type:")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    
                    Text(exercise.exerciseType.rawValue)
                        .font(.system(size: 18))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ExerciseDetailsView(exercise: ExerciseResponse(
        id: 1,
        name: "Some Plan",
        description: "First do this, then do that, finally do that",
        imagePath: "SomePath",
        primaryMuscleGroup: MuscleGroup.back,
        secondaryMuscleGroup: MuscleGroup.bicep,
        exerciseType: ExerciseType.strength,
        forceType: ForceType.push
    ))
}
