//
//  WorkoutPlanService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

protocol WorkoutPlanService {
    func list() async throws -> [WorkoutPlanResponse]
    func create(name: String, ids: [Int64]) async throws -> WorkoutPlanCreateResponse
}
