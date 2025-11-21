//
//  WorkoutPlanView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 16/09/2025.
//

import SwiftUI

struct WorkoutPlanView: View {
    @StateObject private var viewModel: WorkoutPlanViewModel = WorkoutPlanViewModel()
    
    var body: some View {
        TabPage(title: "Workout Plans"){
            SearchInputField(value: $viewModel.searchText, placeholder: "Search workout plans")
        }
    }
}

#Preview {
    WorkoutPlanView()
}
