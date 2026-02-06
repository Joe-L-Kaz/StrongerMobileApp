//
//  WorkoutPlanCreateRequest.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

struct WorkoutPlanCreateRequest : Codable {
    let name: String
    let associatedExercises: [Int64]
}
