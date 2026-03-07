//
//  ProfileView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/03/2026.
//

import SwiftUI
import Foundation

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()
    @State private var showSaveError = false
    @State private var saveErrorMessage = ""

    var body: some View {
        TabPage(title: "Profile") {
            VStack(alignment: .leading, spacing: 16) {

                // Header card
                VStack(alignment: .leading, spacing: 6) {
                    Text("Training schedule")
                        .font(.headline)
                    Text("Pick the days you normally train. We'll use this to schedule reminders.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                // Days selection
                VStack(spacing: 0) {
                    ForEach(viewModel.days) { day in
                        Toggle(isOn: viewModel.bindingForDay(day)) {
                            Text(day.name)
                        }
                        .padding(.vertical, 10)

                        if day.id != viewModel.days.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                // Summary + debug value (useful while building)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Selected")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(viewModel.selectedDaysSummary)
                            .font(.subheadline)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Bitmask (byte)")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(viewModel.trainingDaysByteValue)")
                            .font(.system(.subheadline, design: .monospaced))
                    }

                    HStack {
                        Text("Bitmask (binary)")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(viewModel.trainingDaysBinaryString)
                            .font(.system(.subheadline, design: .monospaced))
                    }
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                // Save button (wire this up to your API when ready)
                Button {
                    Task {
                        try await viewModel.setDays()
                    }
                    
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)

                Spacer(minLength: 0)
            }
            .alert("Save failed", isPresented: $showSaveError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(saveErrorMessage)
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}
