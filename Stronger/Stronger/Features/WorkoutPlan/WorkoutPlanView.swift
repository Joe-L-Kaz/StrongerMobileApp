//
//  WorkoutPlanView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 16/09/2025.
//

import SwiftUI

struct WorkoutPlanView: View {
    @StateObject private var viewModel: WorkoutPlanViewModel = WorkoutPlanViewModel()
    let columns = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        TabPage(title: "Workout Plans"){
            SearchInputField(value: $viewModel.searchText, placeholder: "Search workout plans")
            
            ScrollView {
                if viewModel.failedToLoad {
                    Text(viewModel.failureMessage)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: columns ,alignment: .center, spacing: 10) {
                        ForEach(viewModel.workoutPlans, id: \.id   ) { plan in
                            WorkoutPlanCard(title: plan.name)
                        }
                    }
                    .padding(5)
                }
                
            }
            .scrollIndicators(.hidden)
            .refreshable {
                do {
                    try await viewModel.getWorkoutPlans()
                } catch {}
            }
            .task {
                do {
                    try await viewModel.getWorkoutPlans()
                } catch {}
            }
        }
    }
}

#Preview {
    WorkoutPlanView()
}
