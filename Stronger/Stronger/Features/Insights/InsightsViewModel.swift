//
//  InsightsViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

import Foundation

@MainActor
final class InsightsViewModel: ObservableObject {
    @Published var plotPointExercises : Dictionary<String, [Plot]> = [:]
    
    private let sessionService: SessionService
    
    init(sessionService: SessionService = SessionServiceImpl()) {
        self.sessionService = sessionService
    }
    
    
    func getInsights() async throws -> Void {
        var plots : Dictionary<String,[Plot]> = [:]
        do {
             let response = try await sessionService.getInsights()
            plots = response.plots
        } catch {
            throw error
        }
        
        plotPointExercises = plots
    }
}
