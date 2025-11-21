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
        VStack (spacing: 10) {
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
            
            VStack(spacing: 5) {
                Text("Muscle Groups")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                
                Text("back")
                
                if(exercise.secondaryMuscleGroup != nil){
                    Text(exercise.secondaryMuscleGroup!.rawValue)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

#Preview {
    ExerciseDetailsView(exercise: ExerciseResponse(
        id: 1,
        name: "Some Plan",
        description: "First do this, then do that, finally do that.",
        imagePath: "SomePath",
        primaryMuscleGroup: MuscleGroup.back,
        secondaryMuscleGroup: MuscleGroup.bicep,
        exerciseType: ExerciseType.strength,
        forceType: ForceType.push
    ))
}
