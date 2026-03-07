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
            
            NavigationStack{
                WorkoutPlanView()
            }
            .tabItem {
                Image(systemName: "figure.strengthtraining.traditional")
                Text("Workout Plan")
            }
            
            ExercisesView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Exercises")
                }
            InsightsView()
                .tabItem{
                    Image(systemName: "chart.xyaxis.line")
                    Text("Insights")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    DashboardView()
}
