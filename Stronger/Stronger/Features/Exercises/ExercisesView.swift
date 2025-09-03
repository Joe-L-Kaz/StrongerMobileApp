//
//  ExercisesView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct ExercisesView: View {
    @StateObject private var viewModel = ExercisesViewModel()
    
    var body: some View {
        TabPage(title: "Exercises") {
            SearchInputField(value: $viewModel.searchText, placeholder: "Search")
            
            ScrollView(){
                VStack{
                    ExerciseCard(
                        title: "Bench Press",
                        imageUri: "/Users/joseph/Pictures/Placeholder.jpeg"
                    )
                    
                    ExerciseCard(
                        title: "Bench Press",
                        imageUri: "/Users/joseph/Pictures/Placeholder.jpeg"
                    )
                    
                    ExerciseCard(
                        title: "Bench Press",
                        imageUri: "/Users/joseph/Pictures/Placeholder.jpeg"
                    )
                    
                    ExerciseCard(
                        title: "Bench Press",
                        imageUri: "/Users/joseph/Pictures/Placeholder.jpeg"
                    )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ExercisesView()
}
