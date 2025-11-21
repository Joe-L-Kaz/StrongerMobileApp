//
//  Dashboard.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//
import SwiftUI

struct DashboardView : View {
    var body: some View {
        TabView {
            
            WorkoutPlanView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Workout Plan")
                }
            
            ExercisesView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Exercises")
                }
        }
    }
}

#Preview {
    DashboardView()
}
