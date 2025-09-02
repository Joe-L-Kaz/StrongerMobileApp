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
            Text("Hello")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                    
                }
            
            Text("There")
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
