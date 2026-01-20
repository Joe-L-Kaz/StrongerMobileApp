//
//  WorkoutPlanSession.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 17/01/2026.
//

import SwiftUI

struct WorkoutPlanSessionView : View {
    let workoutPlan: WorkoutPlanResponse
    @StateObject private var viewModel : WorkoutPlanSessionViewModel
    
    init(workoutPlan: WorkoutPlanResponse){
        self.workoutPlan = workoutPlan
        _viewModel = StateObject(
            wrappedValue: WorkoutPlanSessionViewModel(workoutPlan: workoutPlan
        ))
    }
    
    var body: some View {
        TabPage(title: workoutPlan.name) {
            ForEach(workoutPlan.exercises, id: \.id){ exercise in
                ExerciseItem(exercise: exercise, viewModel: viewModel)
            }
            
        }
    }
}

struct ExerciseItem : View {
    let exercise: ExerciseResponse
    @ObservedObject var viewModel: WorkoutPlanSessionViewModel
    
    var body: some View {
        VStack {
            Text(exercise.name)
                .bold()
            
            Metrics()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 2, x: 0, y: -1)
    }
}

struct Metrics : View {
    @State var reps: String = ""
    @State var restTime: String = ""
    @State var weightKg: String = ""
    var body: some View {
        HStack {
            InputField(value: $reps, placeholder: "1")
            InputField(value: $restTime, placeholder: "1")
            InputField(value: $weightKg, placeholder: "1")
        }
    }
}

struct ExerciseSet {
    let setNumber: Int64
    let repCount: Int = 0
    let weightKg: Float? = 0
    let restTimeSeconds: Float? = nil
}

#Preview {
    WorkoutPlanSessionView(
        workoutPlan:
            WorkoutPlanResponse(
                id: 1,
                name: "Plan 1",
                exercises: [
                    ExerciseResponse(
                        id: 1,
                        name: "Barbell Bench Press",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 2,
                        name: "Pull Up",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    ),
                    ExerciseResponse(
                        id: 3,
                        name: "Squat",
                        description: "First do this, then do that, finally do that",
                        imagePath: "SomePath",
                        primaryMuscleGroup: MuscleGroup.back,
                        secondaryMuscleGroup: MuscleGroup.bicep,
                        exerciseType: ExerciseType.strength,
                        forceType: ForceType.push
                    )
                ]
        ),
    )
}
