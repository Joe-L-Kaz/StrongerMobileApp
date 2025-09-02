//
//  ExercisesView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct ExercisesView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        TabPage(title: "Exercises") {
            SearchInputField(value: $searchText, placeholder: "Search")
            
            ScrollView {
                
            }
        }
    }
}

#Preview {
    ExercisesView()
}
