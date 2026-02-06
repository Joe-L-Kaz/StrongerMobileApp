//
//  WorkoutPlanCreateView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//
import SwiftUI

struct WorkoutPlanCreateView: View {
    var onCompleted: () -> Void
    @StateObject private var viewModel = WorkoutPlanCreateViewModel()
    
    let columns = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        TabPage(title: "Create Workout Plan"){
            
            HStack{
                SearchInputField(value: $viewModel.planName, placeholder: "Please enter a plan name")
                LoadingButton(isLoading: $viewModel.isLoading, onSubmit: {
                    Task{
                        do{
                            try await viewModel.createPlan(onSuccess: onCompleted)
                        } catch {}
                        
                    }
                }){
                    Text("Create")
                }
            }
            
            ScrollView {
                if viewModel.failedToLoad {
                    Text(viewModel.failureMessage)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: columns ,alignment: .center, spacing: 10) {
                        ForEach(viewModel.exercises, id: \.id   ) { exercise in
                            ExerciseButton(
                                id: exercise.id,
                                title: exercise.name,
                                imageUri: "http://localhost:5020/images/" + (exercise.imagePath ?? ""),
                                viewModel: viewModel
                            )
                        }
                    }
                    .padding(5)
                }
            }
            .scrollIndicators(.hidden)
            .task {
                do {
                    try await viewModel.getExercises()
                } catch {}
            }
        }
        
    }
}

#Preview {
    WorkoutPlanCreateView(onCompleted: {})
}
