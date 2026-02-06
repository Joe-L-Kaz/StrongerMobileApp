//
//  WorkoutPlanSession.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 17/01/2026.
//

import SwiftUI

struct WorkoutPlanSessionView : View {
    let workoutPlan: WorkoutPlanResponse
    public let onSuccess: () -> Void
    @StateObject private var viewModel : WorkoutPlanSessionViewModel
    
    init(workoutPlan: WorkoutPlanResponse, onSuccess: @escaping () -> Void){
        self.workoutPlan = workoutPlan
        self.onSuccess = onSuccess
        _viewModel = StateObject(
            wrappedValue: WorkoutPlanSessionViewModel(workoutPlan: workoutPlan
        ))
    }
    
    var body: some View {
        TabPage(title: workoutPlan.name) {
            
            ScrollView {
                ForEach(workoutPlan.exercises, id: \.id){ exercise in
                    ExerciseItem(exercise: exercise, viewModel: viewModel)
                }
                
                LoadingButton(
                    isLoading: $viewModel.isLoading,
                    onSubmit: {
                        Task {
                            do{
                                try await viewModel.submitSession(){
                                    onSuccess()
                                }
                            } catch {
                                
                            }
                        }
                    }){
                    Text("Submit")
                }
            }
        }
    }
}

struct ExerciseItem : View {
    let exercise: ExerciseResponse
    @ObservedObject var viewModel: WorkoutPlanSessionViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Button(action: {viewModel.removeSet(exerciseId: exercise.id)}) {
                    Image(systemName: "minus")
                        .foregroundStyle(.red)
                }
                
                Spacer()
                
                Text(exercise.name)
                    .bold()
                
                Spacer()
                
                Button(action: {viewModel.addSet(exerciseId: exercise.id)}) {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                }
            }
            
            ForEach(viewModel.gatheredMetrics[exercise.id]!, id: \.setNumber) {set in
                Metrics(viewModel: viewModel, exerciseId: exercise.id, setNumber: set.setNumber)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 2, x: 0, y: -1)
    }
}

struct Metrics : View {
    @ObservedObject var viewModel: WorkoutPlanSessionViewModel
    
    let exerciseId: Int64
    let setNumber: Int
    
    @State var reps: String = ""
    @State var restTime: String = ""
    @State var weightKg: String = ""
    
    private func pushUpdate() {
        let repsInt = Int(reps) ?? 0
        let weight = Float(weightKg)
        let rest = Int((Float(restTime) ?? 0) * 60)
        
        viewModel.updateSet(
            exerciseId: exerciseId,
            setNumber: setNumber,
            newSet: ExerciseSet(setNumber: setNumber, repCount: repsInt, weightKg:weight, restTimeSeconds: rest)
        )
    }
    
    var body: some View {
        HStack {
            VStack{
                Text("Reps")
                InputField(value: $reps, placeholder: "1")
                    .onChange(of: reps) {
                        pushUpdate()
                    }
            }
            
            VStack{
                Text("Rest(m)")
                InputField(value: $restTime, placeholder: "1")
                    .onChange(of: restTime){
                        pushUpdate()
                    }
            }
            
            VStack{
                Text("Weight(kg)")
                InputField(value: $weightKg, placeholder: "1")
                    .onChange(of: weightKg){
                        pushUpdate()
                    }
            }
            
        }
    }
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
        onSuccess: {}
    )
}
