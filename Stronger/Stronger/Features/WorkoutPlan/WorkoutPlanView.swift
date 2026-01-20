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

    private enum Route: Hashable {
        case logSession(planId: Int)
    }

    @State private var path = NavigationPath()
    @State private var selectedPlan: WorkoutPlanResponse? = nil
    
    var body: some View {
        NavigationStack(path: $path) {
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
                            WorkoutPlanCard(title: plan.name){
                                selectedPlan = plan
                            }
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
            .sheet(item: $selectedPlan) { plan in
                WorkoutPlanDetailsView(workoutPlan: plan) {
                    selectedPlan = nil

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        path.append(Route.logSession(planId: plan.id))
                    }
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .logSession(let planId):
                    let plan = viewModel.workoutPlans.filter{$0.id == planId}
                    WorkoutPlanSessionView(workoutPlan: plan.first!)
                }
            }
        }
    }
}

#Preview {
    WorkoutPlanView()
}
