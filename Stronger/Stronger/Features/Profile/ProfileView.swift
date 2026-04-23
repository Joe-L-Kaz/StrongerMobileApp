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
    @State private var showSaveAlert = false
    @State private var saveAlertTitle = ""
    @State private var saveAlertMessage = ""

    var body: some View {
        TabPage(title: "Profile") {
            VStack(alignment: .leading, spacing: 16) {

                // Header card
                VStack(alignment: .leading, spacing: 6) {
                    Text("Training schedule")
                        .font(.headline)
                    Text("Pick the days you normally train.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

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

                Button {
                    Task {
                        do {
                            try await viewModel.setDays()
                            saveAlertTitle = "Saved"
                            saveAlertMessage = "Your training days were updated successfully."
                            showSaveAlert = true
                        } catch {
                            saveAlertTitle = "Save failed"
                            saveAlertMessage = error.localizedDescription
                            showSaveAlert = true
                        }
                    }
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)

                Spacer(minLength: 0)
            }
            .alert(saveAlertTitle, isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(saveAlertMessage)
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}
