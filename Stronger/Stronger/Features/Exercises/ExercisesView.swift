//
//  ExercisesView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct ExercisesView: View {
    @StateObject private var viewModel = ExercisesViewModel()
    
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
                            ExerciseCard(title: exercise.name, imageUri: exercise.imagePath ?? "")
                        }
                    }
                    .padding(5)
                }
            }
            .scrollIndicators(.hidden)
            .refreshable {
                do {
                    try await viewModel.getExercises()
                } catch {
                    
                    // TODO: handle error (e.g., set an @Published error message)
                    print("Refresh failed: \(error)")
                }
            }
            .task {
                do {
                    try await viewModel.getExercises()
                } catch {
                    print("Initial load failed: \(error)")
                }
            }
        }
    }
}

#Preview {
    ExercisesView()
}
