//
//  WorkoutPlanService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

protocol WorkoutPlanService {
    func List() async throws -> [WorkoutPlanResponse]
}
