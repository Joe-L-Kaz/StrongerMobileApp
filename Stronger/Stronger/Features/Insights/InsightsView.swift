//
//  InsightsView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @StateObject private var viewModel = InsightsViewModel()

    var body: some View {
        NavigationStack {
            TabPage(title: "Insights") {
                Group {
                    if viewModel.plotPointExercises.isEmpty {
                        VStack(spacing: 12) {
                            Text("No insights yet")
                                .font(.headline)
                            Text("Log a workout session to start seeing progress charts.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    } else {
                        List {
                            Section("Exercises") {
                                ForEach(viewModel.plotPointExercises.keys.sorted(), id: \.self) { exerciseName in
                                    NavigationLink(value: exerciseName) {
                                        HStack {
                                            Text(exerciseName)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .font(.caption)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        .background(Color.white)
                    }
                }
            }
            .navigationDestination(for: String.self) { exerciseName in
                GraphView (
                    exerciseName: exerciseName,
                    plots: viewModel.plotPointExercises[exerciseName] ?? []
                )
            }
        }
        .task {
            do {
                try await viewModel.getInsights()
            } catch {
                print("Failed to load insights:", error)
            }
        }
    }
}

#Preview {
    InsightsView()
}
