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
                LazyVGrid(columns: columns ,alignment: .center, spacing: 10) {
//                    ForEach(viewModel.exercises) { exercise in
//                        ExerciseCard(title: exercise.name, imageUri: exercise.imagePath)
//                    }
                }
                .padding(5)
            }
            .scrollIndicators(.hidden)
            
            StaticButton(onSubmit: {
                Task {
                    try await viewModel.getExercises()
                }
            }) {
                Text("Fetch")
            }
        }
    }
}

#Preview {
    ExercisesView()
}
