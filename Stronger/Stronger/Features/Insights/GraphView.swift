//
//  GraphView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/02/2026.
//

import SwiftUI
import Charts

struct GraphView: View {
    let exerciseName: String
    let plots: [Plot]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(exerciseName)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                if plots.isEmpty {
                    Text("No data points for this exercise yet.")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    let xDomain = plots.map(\.date)
                    Chart {
                        ForEach(Array(plots.enumerated()), id: \.offset) { _, p in
                            LineMark(
                                x: .value("Date", p.date),
                                y: .value("Weight", p.maxWeight)
                            )

                            PointMark(
                                x: .value("Date", p.date),
                                y: .value("Weight", p.maxWeight)
                            )
                            .symbol(Circle())
                            .symbolSize(40)
                        }
                    }
                    .chartXScale(domain: xDomain)
                    .chartXAxis {
                        AxisMarks(values: xDomain) { _ in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel()
                        }
                    }
                    .frame(height: 260)
                }
            }
            .padding()
        }
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
    }
}
