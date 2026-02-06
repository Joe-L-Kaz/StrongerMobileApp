//
//  ExercisesView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct ExercisesView: View {
    @StateObject private var viewModel = ExercisesViewModel()
    @State private var selectedExercise: ExerciseResponse? = nil
    
    let columns = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        TabPage(title: "Exercises") {
            SearchInputField(value: $viewModel.searchText, placeholder: "Search")
            
            ScrollView {
                if viewModel.failedToLoad {
                    Text(viewModel.failureMessage)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: columns ,alignment: .center, spacing: 10) {
                        ForEach(viewModel.exercises, id: \.id   ) { exercise in
                            
                            if(viewModel.searchText.isEmpty){
                                ExerciseCard(
                                    title: exercise.name,
                                    imageUri: "http://localhost:5020/images/" + (exercise.imagePath ?? ""),
                                    onInfoTapped: {
                                        selectedExercise = exercise
                                    }
                                )
                            } else {
                                if (exercise.name.lowercased().contains(viewModel.searchText.lowercased())){
                                    ExerciseCard(
                                        title: exercise.name,
                                        imageUri: "http://localhost:5020/images/" + (exercise.imagePath ?? ""),
                                        onInfoTapped: {
                                            selectedExercise = exercise
                                        }
                                    )
                                }
                            }
                            
                        }
                    }
                    .padding(5)
                }
            }
            .scrollIndicators(.hidden)
            .refreshable {
                do {
                    try await viewModel.getExercises()
                } catch {}
            }
            .task {
                do {
                    try await viewModel.getExercises()
                } catch {}
            }
            .sheet(item: $selectedExercise){ exercise in
                ExerciseDetailsView(exercise: exercise)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    ExercisesView()
}
