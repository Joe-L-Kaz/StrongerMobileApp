//
//  WorkoutPlanDetailsView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/11/2025.
//

import SwiftUI

struct WorkoutPlanDetailsView : View {
    let workoutPlan: WorkoutPlanResponse
    let startPlan: () -> Void
    var body: some View{
        Sheet {
            Text(workoutPlan.name)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
                .truncationMode(.tail)
            
            ScrollView {
                VStack (spacing: 20){
                    ForEach(workoutPlan.exercises, id: \.id) { exercise in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(exercise.name)
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                            
                            Text(exercise.description)
                            
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
                    }
                }
            }
            Spacer()
            StaticButton(onSubmit: startPlan){
                Text("Start")
            }
        }
    }
}

#Preview{
    WorkoutPlanDetailsView(
        workoutPlan:
            WorkoutPlanResponse(
                id: 1,
                name: "Plan 1",
                exercises: [
                    ExerciseResponse(
                        id: 1,
                        name: "Some Exercise",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 1,
                        name: "Another exercise ",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    )
                ]
        ),
        startPlan: {}
    )
}
