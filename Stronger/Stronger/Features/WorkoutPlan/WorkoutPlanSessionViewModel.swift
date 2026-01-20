//
//  WorkoutPlanSessionViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 17/01/2026.
//

import Foundation

@MainActor
public final class WorkoutPlanSessionViewModel: ObservableObject {
    @Published var gatheredMetrics: Dictionary<Int64, [ExerciseSet]> = [:]
    
    init(workoutPlan: WorkoutPlanResponse){
        for exercise in workoutPlan.exercises {
            gatheredMetrics.updateValue([ExerciseSet(setNumber: 1)], forKey: exercise.id)
        }
        
    }
}
